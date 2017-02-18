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
    @NSManaged var priceUnit: String
    @NSManaged var detailDescription: String
    @NSManaged var phoneNumber: Double
    @NSManaged var creator: User
    @NSManaged var tags: [String]
    @NSManaged var frontImage: PFFile?
    @NSManaged var avgStars: Double
    @NSManaged var numOfReviews: Int
    
    override init() {
        super.init()
    }
    
    init(gig: Gig) {
        super.init()
        updateFrom(gig: gig)
    }
    
    func updateFrom(gig: Gig) {
        title = gig.title
        price = gig.price
        priceUnit = gig.priceUnit
        detailDescription = gig.description
        phoneNumber = gig.phoneNumber
        creator = gig.creator.updatedUser
        self.isDraft = gig.isDraft
        tags = gig.tags.map({ (tag: String) -> String in
            return tag.lowercased()
        })
        if let file = Helpers.saveImageAsPFFIle(fileName: "gigImage.jpg", image: gig.frontImage) {
            frontImage = file
        }
        avgStars = gig.avgStars
        numOfReviews = gig.numOfReviews
    }
    
    //creating an empty data object is when we need to save a pointer, but haven't actually saved the object yet. Like when we save gigPhotos, we save the photos in a join table, and we need to set the pointer, even though we haven't yet saved the actual gig.
    static func createEmptyDataObject() -> GigParse {
        let g = PFObject(withoutDataWithClassName: "GigParse", objectId: Helpers.createParseObjectID()) as! GigParse
        return g
    }
}
