//
//  RestClientManager.swift
//  RestClient
//
//  Created by Ulaş Sancak on 17.02.2020.
//  Copyright © 2020 Ulaş Sancak. All rights reserved.
//

import Foundation

/// Manager completion block
public typealias RestClientResponse = (Result<Data, RestError>) -> ()

/// Manager which use RestEntpoint instance to start the request with URLSession. It controls the session. It can start and end the request.
internal class RestClientManager {
    
    //MARK: Private properties
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    /// The state of current request.
    internal var state: RestClientState = .idle
    
    /// The URLSessionTask instance of current request.
    internal var task: URLSessionTask?
    
}

//MARK: Control The Manager
extension RestClientManager {
    /// Start the manager with RestEndpoint instance which includes URL etc.
    /// - Parameters:
    ///   - endpoint: RestEndPoint instance
    ///   - completion: Comploetion block which has data and/or error
    func start(endpoint: RestEndpoint, completion: @escaping RestClientResponse) {
        var request: URLRequest?
        do {
            request = try endpoint.createRequest()
        } catch let error {
            state = .suspended
            completion(.failure(RestError.urlSession(error: error)))
            return
        }
        guard let realRequest = request else {
            state = .suspended
            completion(.failure(RestError.unknown))
            return
        }
        task = session.dataTask(with: realRequest) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self?.state = .suspended
                    let error = error as NSError
                    if error.code == NSURLErrorCancelled {
                        completion(.failure(RestError.cancelled))
                    } else {
                        completion(.failure(RestError.urlSession(error: error)))
                    }
                }
                else if let data = data {
                    self?.state = .completed
                    completion(.success(data))
                }
                else {
                    self?.state = .suspended
                    completion(.failure(RestError.unknown))
                }
            }
        }
        state = .running
        task?.resume()
    }
    
    /// End the manager
    func end() {
        task?.cancel()
        task = nil
    }
}
