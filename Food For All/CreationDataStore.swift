//
//  CreationDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

protocol CreationDataStoreDelegate {
    func errorOccurred(description: String)
    func finishedSaving(gig: Gig)
}

class CreationDataStore {
    var delegate: CreationDataStoreDelegate?
    
    init(delegate: CreationDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func save(gig: Gig) {
        let g = GigParse(gig: gig)
        g.saveInBackground { (success, error) in
            if success {
                gig.gigParse = g
                self.delegate?.finishedSaving(gig: gig)
            } else if let error = error {
                self.delegate?.errorOccurred(description: error.localizedDescription)
                print(error)
            }
        }
    }
}
