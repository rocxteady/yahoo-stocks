//
//  ViewController.swift
//  YahooStocks
//
//  Created by Ulaş Sancak on 10.07.2021.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let api = MarketSummaryAPI()
        api.rx_start().subscribe { response in
            print(response)
        } onError: { error in
            print(error.localizedDescription)
        } onCompleted: {
            print("Completed")
        } onDisposed: {
            print("Disposed")
        }.disposed(by: disposeBag)

    }


}

