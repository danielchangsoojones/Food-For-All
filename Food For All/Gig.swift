//
//  Gig.swift
//  Food For All
//
//  Created by Daniel Jones on 1/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

class Gig {
    var title: String = ""
    var priceUnit: String = ""
    var description: String = ""
    var phoneNumber: Int = 0
    var creator: Person = Person.current()
    var isDraft: Bool = false
    var tags: [String] = []
    
    var fullSizeFrontImage: Any?
    var frontImage: Any?
    
    private var _price: Double = 0.0
    var price: Double {
        get {
            return _price
        }
        set (newValue) {
            let roundedValue = newValue.getRoundedByPlaces(2)
            _price = roundedValue
        }
    }
    
    var gigParse: GigParse!
    
    init() {}
    
    init(gigParse: GigParse) {
        self.gigParse = gigParse
        self.title = gigParse.title
        self.price = gigParse.price
        self.description = gigParse.detailDescription
        self.phoneNumber = gigParse.phoneNumber
        let person = Person(user: gigParse.creator)
        self.creator = person
        self.frontImage = creator.profileImage
    }
    
    convenience init(title: String, price: Double, description: String, phoneNumber: Int, creator: Person, gigParse: GigParse) {
        self.init(gigParse: gigParse)
    }
    
}
