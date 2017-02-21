//
//  GigPhoto.swift
//  Food For All
//
//  Created by Daniel Jones on 2/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

//a gig photo are the images that a freelancer can have below their description
class GigPhoto {
    var smallImageFile: Any?
    var fullImageFile: Any?
    
    var smallImage: UIImage?
    private var _fullImage: UIImage?
    var fullImage: UIImage? {
        get {
            return _fullImage
        }
        set (newValue) {
            if let newValue = newValue {
                _fullImage = Camera.resize(image: newValue, targetSize: CGSize(width: 420, height: 420))
                smallImage = Camera.resize(image: newValue, targetSize: CGSize(width: 150, height: 150))
            }
        }
    }
    
    var position: Int = 0
    var parent: Gig
    
    var gigDetailPhoto: GigDetailPhoto = GigDetailPhoto()
    
    init(parent: Gig) {
        self.parent = parent
    }
    
    init(gigDetailPhoto p: GigDetailPhoto, gig: Gig) {
        gigDetailPhoto = p
        smallImageFile = p.smallImageFile
        fullImageFile = p.fullImageFile
        position = p.position
        parent = gig
    }
}
