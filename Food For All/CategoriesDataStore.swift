//
//  EntryDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol CategoriesDataStoreDelegate {
//    func segueIntoApp(gigs: [Gig], vcTitle: String)
//    func removeSpinner()
    func loaded(gigs: [Gig])
}

class CategoriesDataStore {
    var delegate: CategoriesDataStoreDelegate?
    
    init(delegate: CategoriesDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func loadGigs() {
        let query = GigParse.query() as! PFQuery<GigParse>
        query.cachePolicy = .cacheThenNetwork
        query.includeKey("creator")
        
        let creatorQuery = User.query()!
        creatorQuery.whereKey("location", nearGeoPoint: PFGeoPoint(location: User.current()?._location), withinMiles: TransactionFeedDataStore.Constants.distanceRadius)
        query.whereKey("creator", matchesQuery: creatorQuery)
        
        query.order(byDescending: "numOfReviews")
        query.addDescendingOrder("updatedAt")
        
        query.findObjectsInBackground { (gigParses, error) in
            if let gigParses = gigParses {
                let gigs = gigParses.map({ (g: GigParse) -> Gig in
                    let gig = Gig(gigParse: g)
                    return gig
                })
                self.delegate?.loaded(gigs: gigs)
            } else if let error = error {
                print(error)
            }
        }
    }
    
    
//    func findGigsWith(tag: String) {
//        let query = GigParse.query() as! PFQuery<GigParse>
//        query.whereKey("tags", equalTo: tag.lowercased())
//        
//        if tag.lowercased() != "milk mooovers" {
//            let creatorQuery = User.query()!
//            creatorQuery.whereKey("location", nearGeoPoint: PFGeoPoint(location: User.current()?._location), withinMiles: TransactionFeedDataStore.Constants.distanceRadius)
//            query.whereKey("creator", matchesQuery: creatorQuery)
//        }
//        
//        
//        query.includeKey("creator")
//        query.order(byDescending: "numOfReviews")
//        query.addDescendingOrder("updatedAt")
//        query.findObjectsInBackground { (gigParses: [GigParse]?, error) in
//            if let gigParses = gigParses {
//                let gigs = gigParses.map({ (g: GigParse) -> Gig in
//                    let gig = Gig(gigParse: g)
//                    return gig
//                })
//                self.delegate.segueIntoApp(gigs: gigs, vcTitle: tag)
//            } else if let error = error {
//                print(error)
//                Helpers.showBanner(title: "Error", subtitle: error.localizedDescription, bannerType: .error)
//                self.delegate.removeSpinner()
//            }
//        }
//    }
}
