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
        let creator = gig.creator
        PFObject.saveAll(inBackground: [creator, g]) { (success, error) in
            if success {
                gig.gigParse = g
                self.saveDependents(gig: gig)
                self.delegate?.finishedSaving(gig: gig)
            } else if let error = error {
                self.delegate?.errorOccurred(description: error.localizedDescription)
                print(error)
            }
        }
    }
    
    fileprivate func saveDependents(gig: Gig) {
        let photos = saveDetailPhotos(gig: gig)
        let fullImage = saveFullGigImage(gig: gig)
        var objects: [PFObject] = [fullImage]
        objects.append(contentsOf: photos as [PFObject])
        PFObject.saveAll(inBackground: objects)
    }
    
    func saveDetailPhotos(gig: Gig) -> [GigDetailPhoto] {
        let detailPhotos: [GigDetailPhoto] = gig.photos.map { (photo: GigPhoto) -> GigDetailPhoto in
            let detailPhoto = photo.gigDetailPhoto
            detailPhoto.update(from: photo)
            return detailPhoto
        }
        return detailPhotos
    }
    
    fileprivate func saveFullGigImage(gig: Gig) -> GigImage {
        let gigImage = GigImage(gig: gig)
        return gigImage
    }
}
