//
//  GigParse.swift
//  Food For All
//
//  Created by Daniel Jones on 1/24/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class GigParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "GigParse"
    }
    
    @NSManaged var title: String
    @NSManaged var price: Double
    @NSManaged var detailDescription: String
    @NSManaged var phoneNumber: Int
    @NSManaged var creator: User
    @NSManaged var tags: [String]
    @NSManaged var frontImage: PFFile?
    
    override init() {
        super.init()
    }
    
    init(gig: Gig) {
        super.init()
        title = gig.title
        price = gig.price
        detailDescription = gig.description
        phoneNumber = gig.phoneNumber
        creator = gig.creator.user
        tags = gig.tags.map({ (tag: String) -> String in
            return tag.lowercased()
        })
        if let file = Helpers.saveImageAsPFFIle(fileName: "gigImage.jpg", image: gig.frontImage) {
            frontImage = file
        }
    }
}
