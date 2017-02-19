//
//  Review.swift
//  Food For All
//
//  Created by Daniel Jones on 2/11/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Review {
    var creator: User = User.current() ?? User()
    var gig: Gig?
    var updated: Date = Date()
    var description: String?
    var stars: Double = 0
    
    var reviewParse: ReviewParse?
    
    init() {}
    
    init(reviewParse r: ReviewParse) {
        creator = r.creator
        updated = r.updatedAt ?? Date()
        description = r.detail
        stars = r.stars
        reviewParse = r
    }
}

extension Review: Equatable {
    static func ==(lhs: Review, rhs: Review) -> Bool {
        if let leftObjectId = lhs.reviewParse?.objectId, let rightObjectId = rhs.reviewParse?.objectId {
            return leftObjectId == rightObjectId
        }
        return false
    }
}
