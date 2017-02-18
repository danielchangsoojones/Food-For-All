//
//  GigDetailPhoto.swift
//  Food For All
//
//  Created by Daniel Jones on 2/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

//a gig detail photo are the images that a freelancer can have below their description
class GigDetailPhoto: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "GigDetailPhoto"
    }
    
    @NSManaged var position: Int
    @NSManaged var fullImageFile: PFFile?
    @NSManaged var smallImageFile: PFFile?
    @NSManaged var parent: GigParse?
    
    override init() {
        super.init()
    }
    
    func update(from photo: GigPhoto) {
        position = photo.position
        if let fullImage = photo.fullImage {
            fullImageFile = Helpers.saveImageAsPFFIle(fileName: "fullImage.jpg", image: fullImage)
        }
        if let smallImage = photo.smallImage {
            smallImageFile = Helpers.saveImageAsPFFIle(fileName: "fullImage.jpg", image: smallImage)
        }
        parent = photo.parent.gigParse
    }
}
