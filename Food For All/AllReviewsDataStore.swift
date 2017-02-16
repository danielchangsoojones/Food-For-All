//
//  AllReviewsDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol AllReviewsDataStoreDelegate {
    func loaded(reviews: [Review])
}

class AllReviewsDataStore {
    var delegate: AllReviewsDataStoreDelegate?
    
    init(delegate: AllReviewsDataStoreDelegate, gig: Gig) {
        self.delegate = delegate
        searchRatings(gig: gig)
    }
    
    fileprivate func searchRatings(gig: Gig) {
        let query = ReviewParse.query() as! PFQuery<ReviewParse>
        query.whereKey("gig", equalTo: gig.gigParse)
        query.includeKey("creator")
        query.order(byDescending: "updatedAt")
        query.findObjectsInBackground { (reviewParses, error) in
            if let reviewParses = reviewParses {
                let reviews = reviewParses.map({ (r: ReviewParse) -> Review in
                    return Review(reviewParse: r)
                })
                self.delegate?.loaded(reviews: reviews)
            } else if let error = error {
                print(error)
            }
        }
    }
}
