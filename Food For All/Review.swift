//
//  Review.swift
//  Food For All
//
//  Created by Daniel Jones on 2/11/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Review {
    var creator: Person = Person.current()
    var updated: Date = Date()
    var description: String?
    var stars: Double = 0
    
    var reviewParse: ReviewParse?
    
    init() {}
}
