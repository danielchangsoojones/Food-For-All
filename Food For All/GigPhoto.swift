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
    var fullImage: UIImage? {
        didSet {
            if let fullImage = fullImage {
                smallImage = Camera.resize(image: fullImage, targetSize: CGSize(width: 100, height: 100))
            }
        }
    }
    
    var position: Int = 0
    var wasEdited: Bool = false
    var parent: Gig
    
    var gigDetailPhoto: GigDetailPhoto?
    
    init(parent: Gig) {
        self.parent = parent
    }
}
