//
//  UIAlertControllerExtensions.swift
//  YahooStocks
//
//  Created by Ulaş Sancak on 12.07.2021.
//

import UIKit

extension UIViewController {
    
    func presentError(title: String?, message: String?) {
        guard presentedViewController == nil else { return }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
