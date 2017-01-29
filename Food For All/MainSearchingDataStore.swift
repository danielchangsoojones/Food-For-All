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
}

class MainSearchingDataStore {
    var delegate: MainSearchingDelegate?
    fileprivate var isSearching = false
    
    init(delegate: MainSearchingDelegate) {
        self.delegate = delegate
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
                    print(resultTexts)
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
