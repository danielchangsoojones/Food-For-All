//
//  GigParseImage.swift
//  Food For All
//
//  Created by Daniel Jones on 2/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class GigImage: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "GigImage"
    }
    
    @NSManaged var fullFrontImage: PFFile?
    @NSManaged var parent: GigParse!
    
    override init() {
        super.init()
    }
    
    init(gig: Gig) {
        super.init()
        if let fullImage = gig.fullSizeFrontImage as? UIImage {
            self.fullFrontImage = Helpers.saveImageAsPFFIle(fileName: "frontImage.jpg", image: fullImage)
        }
        self.parent = gig.gigParse
    }
}
