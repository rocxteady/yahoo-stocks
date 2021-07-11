//
//  StockSummaryViewController.swift
//  YahooStocks
//
//  Created by Ulaş Sancak on 11.07.2021.
//

import UIKit
import RxSwift
import RxCocoa

class StockSummaryViewController: UITableViewController {

    var viewModel: StockSummaryViewModel?

    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.isDisplaying = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.isDisplaying = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
     }
    
    private func setupUI() {
        tableView.dataSource = nil
        tableView.delegate = nil
        refreshControl = UIRefreshControl()
        title = "Detail"
    }
    
    private func getData() {
        viewModel?.getData()
    }

    private func bind() {
        viewModel?.data.bind(to: tableView.rx.items(cellIdentifier: "StockCell", cellType: UITableViewCell.self)) { (row, model, cell) in
            cell.textLabel?.text = model["title"]
            cell.detailTextLabel?.text = model["value"]
        }.disposed(by: disposeBag)
        
        refreshControl?.rx.controlEvent(.valueChanged).subscribe { [weak self] _ in
            self?.getData()
        }.disposed(by: disposeBag)
        
        viewModel?.isGettingData.subscribe(onNext: { [weak self] isGettingData in
            if !isGettingData {
                self?.refreshControl?.endRefreshing()
            }
        }).disposed(by: disposeBag)

        viewModel?.presentErrorSubject.subscribe { [weak self] error in
            self?.presentError(title: "Error", message: error)
        }.disposed(by: disposeBag)
    }
    
}
