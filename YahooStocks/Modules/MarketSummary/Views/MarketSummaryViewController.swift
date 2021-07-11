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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        viewModel.isDisplaying = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.isDisplaying = false
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
        searchBar.placeholder = "Search Markets"
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
        
        tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            self?.performSegue(withIdentifier: "stockDetail", sender: nil)
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
        
        refreshControl?.rx.controlEvent(.valueChanged).subscribe { [weak self] _ in
            self?.getData()
        }.disposed(by: disposeBag)
        
        viewModel.isGettingData.subscribe(onNext: { [weak self] isGettingData in
            if !isGettingData {
                self?.refreshControl?.endRefreshing()
            }
        }).disposed(by: disposeBag)
        
        viewModel.presentErrorSubject.subscribe { [weak self] error in
            self?.presentError(title: "Error", message: error)
        }.disposed(by: disposeBag)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "stockDetail",
              let indexPath = tableView.indexPathForSelectedRow,
              let stockSummaryViewController = segue.destination as? StockSummaryViewController else { return }
        let market = viewModel.data.value[indexPath.row]
        let stockViewModel = StockSummaryViewModel(symbol: market.symbol)
        stockSummaryViewController.viewModel = stockViewModel
    }

}
