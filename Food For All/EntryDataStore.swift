//
//  EntryDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol EntryDelegate {
    func segueIntoApp(gigs: [Gig], vcTitle: String)
    func removeSpinner()
}

class EntryDataStore {
    var delegate: EntryDelegate
    
    init(delegate: EntryDelegate) {
        self.delegate = delegate
    }
    
    func findGigsWith(tag: String) {
        let query = GigParse.query() as! PFQuery<GigParse>
        query.whereKey("tags", equalTo: tag.lowercased())
        query.includeKey("creator")
//        query.cachePolicy = .cacheElseNetwork
//        query.maxCacheAge = TimeIntervalHelper(minutes: 5.0).timeInterval
        query.findObjectsInBackground { (gigParses: [GigParse]?, error) in
            if let gigParses = gigParses {
                let gigs = gigParses.map({ (g: GigParse) -> Gig in
                    let gig = Gig(gigParse: g)
                    return gig
                })
                self.delegate.segueIntoApp(gigs: gigs, vcTitle: tag)
            } else if let error = error {
                print(error)
                Helpers.showBanner(title: "Error", subtitle: error.localizedDescription, bannerType: .error)
                self.delegate.removeSpinner()
            }
        }
    }
}
