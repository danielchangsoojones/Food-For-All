//
//  TransactionFeedDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol TransactionFeedDataStoreDelegate {
    func loaded(transactions: [Review])
}

class TransactionFeedDataStore {
    struct Constants {
        static let distanceRadius: Double = 60
    }
    
    var delegate: TransactionFeedDataStoreDelegate?
    
    init(delegate: TransactionFeedDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func loadTransactions() {
        let query = ReviewParse.query() as! PFQuery<ReviewParse>
        query.addDescendingOrder("updatedAt")
        
        let innerDistanceQuery = User.query()!
        innerDistanceQuery.whereKey("location", nearGeoPoint: PFGeoPoint(location: User.current()?._location), withinMiles: Constants.distanceRadius)
        query.whereKey("creator", matchesQuery: innerDistanceQuery)
        
        query.includeKey("gig")
        query.includeKey("gig.creator")
        query.includeKey("creator")
        query.selectKeys(["gig.title", "gig.creator.profileImage", "gig.creator.firstName", "gig.creator.lastName", "creator.firstName", "creator.profileImage", "detail", "stars"])
        query.limit = 30
        query.findObjectsInBackground { (reviewParses, error) in
            if let reviewParses = reviewParses {
                let transactions = reviewParses.map({ (r: ReviewParse) -> Review in
                    //I am selecting keys in the query, because we don't need to pull down all data, so I have to customize what gets put into each transaction
                    let review = Review()
                    review.creator = r.creator
                    review.description = r.detail
                    review.stars = r.stars
                    
                    let gig = Gig()
                    gig.gigParse = r.gig
                    gig.title = r.gig.title
                    gig.creator = r.gig.creator
                    review.gig = gig
                    
                    return review
                })
                self.delegate?.loaded(transactions: transactions)
            } else if let error = error {
                print(error)
            }
        }
    }
}
