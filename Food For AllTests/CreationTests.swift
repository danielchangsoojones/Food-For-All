//
//  CreationTests.swift
//  Food For All
//
//  Created by Daniel Jones on 2/11/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import XCTest
@testable import Food_For_All

class CreationTests: XCTestCase {
    var creationVC: CreationViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        creationVC = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let gig = Gig()
        gig.title = "title"
        gig.description = "description"
        gig.frontImage = #imageLiteral(resourceName: "Logo")
        gig.tags = ["laundry"]
        gig.price = 50.0
        gig.priceUnit = "per session"
        gig.creator = Person.current()
        gig.phoneNumber = 3176905323.0
        
       
        XCTAssert(CreationData.validateCompletion(gig: gig, type: .service), "service form is not working")
        XCTAssert(CreationData.validateCompletion(gig: gig, type: .pricing), "pricing form is not working")
        XCTAssert(CreationData.validateCompletion(gig: gig, type: .contact), "contact form is not working")
    }
    
}
