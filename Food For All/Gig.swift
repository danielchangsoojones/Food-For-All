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
    
    init(title: String, price: Double, description: String, phoneNumber: Int, creator: Person) {
        self.title = title
        self.price = price
        self.description = description
        self.creator = creator
        self.phoneNumber = phoneNumber
    }
}
