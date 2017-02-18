//
//  PhotosFormDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class PhotosFormDataStore {
    func saveNewPhoto(photos: [GigPhoto]) {
        if let newPhoto = photos.first {
            let g = newPhoto.gigDetailPhoto
            g.update(from: newPhoto)
            g.saveInBackground()
            print(g.objectId)
        }
        
//        let g = photos.first?.gigDetailPhoto
//        g?.position = 5
//        g?.saveInBackground { (success, error) in
//            print(success)
//        }
//        if let photo = photos.first {
//            let detailPhoto = photo.gigDetailPhoto
//            print(detailPhoto.objectId)
////            detailPhoto.update(from: photo)
//            detailPhoto.saveInBackground(block: { (success, error) in
//                if success {
//                    print("successfullll")
//                }
//            })
//        }
        
//        let detailPhoto: [GigDetailPhoto] = photos.map { (photo: GigPhoto) -> GigDetailPhoto in
//            let detailPhoto = photo.gigDetailPhoto
//            print(detailPhoto)
//            detailPhoto.update(from: photo)
//            return detailPhoto
//        }
//        detailPhoto.first?.saveInBackground()
//        PFObject.saveAll(inBackground: detailPhoto)
    }
}
