//
//  PhotoFormDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol PhotoFormDelegate {
    func recieved(photos: [GigPhoto])
}

class PhotoFormDataStore {
    var delegate: PhotoFormDelegate?
    
    init(delegate: PhotoFormDelegate) {
        self.delegate = delegate
    }
    
    func loadPhotos(for gig: Gig) {
        if gig.gigParse.objectId != nil {
            let query = GigDetailPhoto.query()! as! PFQuery<GigDetailPhoto>
            query.whereKey("parent", equalTo: gig.gigParse)
            query.findObjectsInBackground { (gigDetailPhotos, error) in
                if let gigDetailPhotos = gigDetailPhotos {
                    let photos: [GigPhoto] = gigDetailPhotos.map({ (p: GigDetailPhoto) -> GigPhoto in
                        let photo: GigPhoto = GigPhoto(gigDetailPhoto: p, gig: gig)
                        return photo
                    })
                    self.delegate?.recieved(photos: photos)
                } else if let error = error {
                    print(error)
                }
            }
        }
    }
    
    func delete(photo: GigPhoto) {
        let p = photo.gigDetailPhoto
        p.deleteInBackground()
    }
}
