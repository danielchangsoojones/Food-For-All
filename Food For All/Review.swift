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
    var gig: Gig?
    var updated: Date = Date()
    var description: String?
    var stars: Double = 0
    
    var reviewParse: ReviewParse?
    
    init() {}
    
    init(reviewParse r: ReviewParse) {
        creator = Person(user: r.creator)
//        let gig = Gig(gigParse: r.gig)
//        gig.creator = creator
//        self.gig = gig
        updated = r.updatedAt ?? Date()
        description = r.detail
        stars = r.stars
        reviewParse = r
    }
}
