//
//  The_Fork_TestTests.swift
//  The Fork TestTests
//
//  Created by Giorgio Romano on 19/02/2020.
//  Copyright © 2020 Giorgio Romano. All rights reserved.
//

import XCTest
@testable import The_Fork_Test

class The_Fork_TestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWrongNumberRestaurantNetworkRequest() {
        let api = NetworkAPI()
        let expectation = XCTestExpectation(description: "Download from thefork api")
        api.get(restaurant: Int.max) {
            restaurant in
            XCTAssertNil(restaurant)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20)
    }
    
    func testCorrectRestaurantNetworkRequest() {
        let api = NetworkAPI()
        let expectation = XCTestExpectation(description: "Download from thefork api")
        api.get(restaurant: 6861) {
            restaurant in
            XCTAssertNotNil(restaurant)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20)
    }
    
    func testCorrectParseRestaurantNetworkRequest() {
        let api = NetworkAPI()
        let expectation = XCTestExpectation(description: "Download from thefork api")
        api.get(restaurant: 6861) {
            restaurant in
            guard let restaurant = restaurant else {
                XCTFail()
                expectation.fulfill()
                return
            }
            XCTAssert(restaurant.data.idRestaurant == 6861 && restaurant.data.rateDistinction == "Excellente table")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20)
   }

}
