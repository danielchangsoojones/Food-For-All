//
//  MainSearchingDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 1/29/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import Mixpanel

protocol MainSearchingDelegate {
    func passSearchResults(results: [String])
    func getMostCurrentSearchText() -> String?
    func pass(gigs: [Gig])
    func hideSpinner()
}

class MainSearchingDataStore {
    var delegate: MainSearchingDelegate?
    fileprivate var isSearching = false
    
    init(delegate: MainSearchingDelegate) {
        self.delegate = delegate
    }
    
    func findGigs(title: String) {
        setSearchAnalytic(text: title)
        let lowercasedTitle = title.lowercased()
        
        let titleQuery = SearchGig.query()!
        titleQuery.whereKey("lowercaseTitle", contains: lowercasedTitle)
        
        let tagQuery = SearchGig.query()!
        let innerGigQuery = GigParse.query()!
        innerGigQuery.whereKey("tags", contains: lowercasedTitle)
        tagQuery.whereKey("gigParse", matchesQuery: innerGigQuery)
        
        let orQuery = PFQuery.orQuery(withSubqueries: [titleQuery, tagQuery]) as PFQuery<SearchGig>
        orQuery.includeKey("gigParse")
        orQuery.includeKey("gigParse.creator")
        
        orQuery.findObjectsInBackground { (searchGigs, error) in
            if let searchGigs = searchGigs {
                //TODO: this is not the most effecicient thing because I am mapping and then sorting, should do it all at once. 
                let gigs: [Gig] = searchGigs.map({ (s: SearchGig) -> Gig in
                    let gig = Gig(gigParse: s.gigParse)
                    return gig
                })
                let sortedGigs = gigs.sorted(by: { (gig1: Gig, gig2: Gig) -> Bool in
                    return gig1.avgStars > gig2.avgStars
                })
                self.delegate?.pass(gigs: sortedGigs)
            } else if let error = error {
                print(error)
                Helpers.showBanner(title: "Error", subtitle: error.localizedDescription)
                self.delegate?.hideSpinner()
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
    
    fileprivate func setSearchAnalytic(text: String) {
        Mixpanel.mainInstance().track(event: "Search", properties: ["Text" : text])
    }
}
