//
//  RestClientTests.swift
//  RestClientTests
//
//  Created by Ulaş Sancak on 10.07.2021.
//

import XCTest
@testable import RestClient

class RestClientTests: XCTestCase {

    let endpoint = RestEndpoint(urlString: "https://www.google.com", parameters: ["Parameter": "Value"])
    let endpointForJSON = RestEndpoint(urlString: "https://www.google.com", httpMethod: .post, encodingType: .json, parameters: ["Parameter": "Value"])
    let endpointToFail = RestEndpoint(urlString: "notavalidurl")
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testURL() {
        let url = URL(string: endpoint.urlString)
        XCTAssertNotNil(url, "URL Nil")
        XCTAssertNotNil(url?.host == nil, "URL Not Valid")
    }
    
    func testFailingURL() {
        let url = URL(string: endpointToFail.urlString)
        XCTAssert(url == nil || url?.host == nil, "URL Is Valid")
    }
    
    func testCreatingURLComponents() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        do {
            let urlComponents = try endpoint.createURLComponents()
            XCTAssertNotNil(urlComponents, "URLComponents Nil")
        } catch let error {
            XCTAssert(true, error.localizedDescription)
        }
    }
    
    func testFailingCreatingURLComponents() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        do {
            let urlComponents = try endpointToFail.createURLComponents()
            XCTAssertNil(urlComponents, "URLComponents Should Be Nil")
        } catch let error {
            XCTAssert(true, error.localizedDescription)
        }
    }
    
    func testURLForURLComponents() {
        do {
            let urlComponents = try endpoint.createURLComponents()
            let url = urlComponents?.url
            XCTAssertNotNil(url, "URL Nil")
            XCTAssertNotNil(url?.host == nil, "URL Not Valid")
        } catch let error {
            XCTAssert(true, error.localizedDescription)
        }
    }
    
    func testPercentEncodingQueryForURLComponents() {
        do {
            let urlComponents = try endpoint.createURLComponents()
            let data = urlComponents?.percentEncodedQuery?.data(using: .utf8)
            XCTAssertNotNil(data, "Data Nil")
        } catch let error {
            XCTAssert(true, error.localizedDescription)
        }
    }
    
    func testJSONEncoding() {
        let parameters = endpointForJSON.parameters
        XCTAssertNotNil(parameters, "Parameters Nil")
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters!, options: [])
            XCTAssertNotNil(data, "Data Nil")
        } catch let error {
            XCTAssert(true, error.localizedDescription)
        }
    }

    func testCreatingRequest() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        do {
            let request = try endpoint.createRequest()
            XCTAssertNotNil(request, "Request Nil")
        } catch let error {
            XCTAssert(true, error.localizedDescription)
        }
    }

    func testFailingCreatingRequest() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        do {
            let request = try endpointToFail.createRequest()
            XCTAssertNil(request, "Request Should Be Nil")
        } catch let error {
            XCTAssert(true, error.localizedDescription)
        }
    }

}
