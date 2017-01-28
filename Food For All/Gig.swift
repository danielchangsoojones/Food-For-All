//
//  Gig.swift
//  Food For All
//
//  Created by Daniel Jones on 1/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Gig {
    var title: String = ""
    var price: Double = 0.0
    var description: String = ""
    var phoneNumber: Int = 0
    var creator: Person!
    
    var gigParse: GigParse!
    
    //TODO: just take in a gigParse, and then I can set all the attributes I want from there
    init(title: String, price: Double, description: String, phoneNumber: Int, creator: Person, gigParse: GigParse) {
        self.title = title
        self.price = price
        self.description = description
        self.creator = creator
        self.phoneNumber = phoneNumber
        self.gigParse = gigParse
    }
}
