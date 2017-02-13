//
//  FrontPageDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 1/24/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol FrontPageDataStoreDelegate {
    func pass(gigs: [Gig])
}

class FrontPageDataStore {
    var delegate: FrontPageDataStoreDelegate?
    
    init(delegate: FrontPageDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func loadDefaultGigs() {
        let query = GigParse.query() as! PFQuery<GigParse>
        query.cachePolicy = .cacheThenNetwork
        query.includeKey("creator")
        query.findObjectsInBackground { (gigParses, error) in
            if let gigParses = gigParses {
                let gigs: [Gig] = gigParses.map({ (g: GigParse) -> Gig in
                    let person = Person(user: g.creator)
                    let gig = Gig(title: g.title, price: g.price, description: g.detailDescription, phoneNumber: Int(g.phoneNumber), creator: person, gigParse: g)
                    return gig
                })
                self.delegate?.pass(gigs: gigs)
            } else if let error = error {
                print(error)
            }
        }
    }
}
