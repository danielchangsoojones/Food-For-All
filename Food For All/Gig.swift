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
    var phoneNumber: Double = 0
    var creator: Person = Person.current()
    var isDraft: Bool = false
    var tags: [String] = []
    
    var fullSizeFrontImage: AnyObject?
    var frontImage: AnyObject?
    
    private var _price: Double = -1
    var price: Double {
        get {
            return _price
        }
        set (newValue) {
            let roundedValue = newValue.getRoundedByPlaces(2)
            _price = roundedValue
        }
    }
    var priceString: String {
        return Int(_price.getRoundedByPlaces(0)).toString + "$ " + priceUnit
    }
    
    var gigParse: GigParse!
    
    init() {}
    
    init(gigParse: GigParse) {
        self.gigParse = gigParse
        self.title = gigParse.title
        self.price = gigParse.price
        self.priceUnit = gigParse.priceUnit
        self.description = gigParse.detailDescription
        self.phoneNumber = gigParse.phoneNumber
        let person = Person(user: gigParse.creator)
        self.creator = person
        setGigImage()
    }
    
    convenience init(title: String, price: Double, description: String, phoneNumber: Int, creator: Person, gigParse: GigParse) {
        self.init(gigParse: gigParse)
    }
    
    fileprivate func setGigImage() {
        //Either set the image as the gig image, but if non-existent, then use their profile image
        if let gigImage = gigParse.frontImage {
            self.frontImage = gigImage
        } else if let profileImage = creator.profileImage {
            self.frontImage = profileImage
        }
    }
}
