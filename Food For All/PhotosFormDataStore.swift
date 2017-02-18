//
//  PhotosFormDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 2/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class PhotosFormDataStore {
    func saveNew(photo: GigPhoto) {
        let p = GigDetailPhoto(photo: photo)
        p.saveInBackground()
    }
}
