//
//  ProfileDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol ProfileDataStoreDelegate {
    func loaded(gigs: [Gig])
}

class ProfileDataStore {
    var delegate: ProfileDataStoreDelegate?
    
    init(delegate: ProfileDataStoreDelegate) {
        self.delegate = delegate
        loadPersonalGigs()
    }
    
    func loadPersonalGigs() {
        let query = GigParse.query() as! PFQuery<GigParse>
        query.whereKey("creator", equalTo: User.current() ?? User())
        query.includeKey("creator")
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
}
