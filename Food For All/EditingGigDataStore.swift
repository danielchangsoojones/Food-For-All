//
//  EditingGigDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class EditingGigDataStore: CreationDataStore {
    override func save(gig: Gig) {
        let g = gig.gigParse
        g.updateFrom(gig: gig)
        g.saveInBackground()
        delegate?.finishedSaving(gig: gig)
    }
    
    func delete(gig: Gig) {
        let g = gig.gigParse
        g.deleteInBackground()
        //TODO: make a function for when we finish deleting the gig.
        delegate?.finishedSaving(gig: gig)
    }
}
