//
//  MainSearchingDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 1/29/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol MainSearchingDelegate {
    func passSearchResults(results: [String])
    func getMostCurrentSearchText() -> String?
    func pass(gigs: [Gig])
}

class MainSearchingDataStore {
    var delegate: MainSearchingDelegate?
    fileprivate var isSearching = false
    
    init(delegate: MainSearchingDelegate) {
        self.delegate = delegate
    }
    
    func findGigs(title: String) {
        let query = SearchGig.query()! as! PFQuery<SearchGig>
        query.whereKey("lowercaseTitle", equalTo: title.lowercased())
        query.includeKey("gigParse")
        query.includeKey("gigParse.creator")
        query.findObjectsInBackground { (searchGigs, error) in
            if let searchGigs = searchGigs {
                let gigs: [Gig] = searchGigs.map({ (s: SearchGig) -> Gig in
                    let gig = Gig(gigParse: s.gigParse)
                    return gig
                })
                self.delegate?.pass(gigs: gigs)
            }
        }
    }
}

//search extension
extension MainSearchingDataStore {
    func search(text: String) {
        if !isSearching {
            isSearching = true
            let lowercasedText = text.lowercased()
            PFCloud.callFunction(inBackground: "searchGigs", withParameters: ["searchText": lowercasedText], block: {
                (result: Any?, error: Error?) -> Void in
                if let resultTexts = result as? [String] {
                    self.delegate?.passSearchResults(results: resultTexts)
                } else if let error = error {
                    print(error)
                }
                self.compareToNewestSearch(queriedSearchText: text)
            })
        }
    }
    
    fileprivate func compareToNewestSearch(queriedSearchText: String) {
        if let newestSearchText = delegate?.getMostCurrentSearchText(), queriedSearchText != newestSearchText {
            search(text: newestSearchText)
        }
        isSearching = false
    }
}
