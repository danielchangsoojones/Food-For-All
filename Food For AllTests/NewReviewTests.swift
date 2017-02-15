//
//  NewReviewTests.swift
//  Food For All
//
//  Created by Daniel Jones on 2/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import XCTest
@testable import Food_For_All

class NewReviewTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccesfulValidation() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let isValidData = getValidData(text: "testing description", rating: 2)
        XCTAssertTrue(isValidData)
    }
    
    func testFailedStarsValidation() {
        let isValidData = getValidData(text: "testing description", rating: 0)
        XCTAssertTrue(!isValidData)
    }
    
    func testFailedDescriptionValidation() {
        let isValidData = getValidData(text: "", rating: 2)
        XCTAssertTrue(!isValidData)
    }
    
    fileprivate func getValidData(text: String, rating: Double) -> Bool {
        let newRatingVC = NewRatingViewController()
        _ = newRatingVC.view
        newRatingVC.theTextView.text = text
        newRatingVC.theStarsView.rating = rating
        return newRatingVC.isValidData
    }
}
