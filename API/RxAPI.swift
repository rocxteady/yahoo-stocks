//
//  RxAPI.swift
//  RxAPI
//
//  Created by Ulaş Sancak on 30.03.2020.
//  Copyright © 2020 Ulaş Sancak. All rights reserved.
//

import Foundation
import RxSwift

public extension API {
    
    func rx_start() -> Observable<APIResponse<ResponseModel>> {
        let observable = Observable<APIResponse<ResponseModel>>.create { (observer) -> Disposable in
            self.start { (result) in
                if let error = result.error {
                    observer.onError(error)
                    return
                }
                observer.onNext(result)
                observer.onCompleted()
            }
            return Disposables.create {
                self.end()
            }
        }
        return observable
    }
        
}
