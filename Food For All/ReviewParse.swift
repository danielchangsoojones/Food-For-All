//
//  ReviewParse.swift
//  Food For All
//
//  Created by Daniel Jones on 2/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class ReviewParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "ReviewParse"
    }
    
    @NSManaged var creator: User
    @NSManaged var gig: GigParse
    @NSManaged var detail: String?
    @NSManaged var stars: Double
    
    
    override init() {
        super.init()
    }
    
    init(review: Review) {
        super.init()
        self.creator = review.creator
        self.detail = review.description
        self.stars = review.stars
        if let gig = review.gig {
            let g = gig.gigParse
            self.gig = g
        }
    }
}
