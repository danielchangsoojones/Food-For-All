//
//  CreationDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

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
        let creator = gig.creator.updatedUser
        PFObject.saveAll(inBackground: [creator, g]) { (success, error) in
            if success {
                gig.gigParse = g
                self.saveFullGigImage(gig: gig)
                self.delegate?.finishedSaving(gig: gig)
            } else if let error = error {
                self.delegate?.errorOccurred(description: error.localizedDescription)
                print(error)
            }
        }
    }
    
    fileprivate func saveFullGigImage(gig: Gig) {
        let gigImage = GigImage(gig: gig)
        gigImage.saveInBackground()
    }
}
