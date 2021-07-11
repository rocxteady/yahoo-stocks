//
//  MarketSummaryViewController.swift
//  YahooStocks
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import UIKit
import RxSwift
import RxCocoa

class MarketSummaryViewController: UITableViewController {
    
    let viewModel = MarketSummaryViewModel()

    private let disposeBag = DisposeBag()
    private let searchBar = UISearchBar(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        getData()
     }
    
    private func setupUI() {
        tableView.dataSource = nil
        tableView.delegate = nil
        searchBar.placeholder = "Search Health Point"
        searchBar.showsCancelButton = false
        navigationItem.titleView = searchBar
    }
    
    private func getData() {
        viewModel.getData()
    }

    private func bind() {
        viewModel.data.bind(to: tableView.rx.items(cellIdentifier: "MarketCell", cellType: UITableViewCell.self)) { (row, model, cell) in
            cell.textLabel?.text = model.name
            cell.detailTextLabel?.text = model.regularMarketPreviousClose.fmt
        }.disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe { [weak self] searchTerm in
                self?.viewModel.search(searchTerm: searchTerm)
        }.disposed(by: disposeBag)
        
        searchBar.rx.textDidBeginEditing
            .subscribe { [weak self] _ in
                self?.searchBar.setShowsCancelButton(true, animated: true)
            }.disposed(by: disposeBag)
        
        searchBar.rx.textDidEndEditing
            .subscribe { [weak self] _ in
                self?.searchBar.setShowsCancelButton(false, animated: true)
            }.disposed(by: disposeBag)

        searchBar.rx.cancelButtonClicked
            .subscribe { [weak self] _ in
                self?.viewModel.search()
                self?.searchBar.resignFirstResponder()
            }.disposed(by: disposeBag)
    }

}
