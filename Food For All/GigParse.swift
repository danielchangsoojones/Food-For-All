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
    @NSManaged var creator: User
    @NSManaged var tags: [String]
    @NSManaged var frontImage: PFFile?
    @NSManaged var avgStars: Double
    @NSManaged var numOfReviews: Int
    @NSManaged var estimatedDuration: String?
    @NSManaged var deleted: Bool
    
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
        creator = gig.creator
        creator.phoneNumber = gig.phoneNumber
        tags = gig.tags.map({ (tag: String) -> String in
            return tag.lowercased()
        })
        if let file = Helpers.saveImageAsPFFIle(fileName: "gigImage.jpg", image: gig.frontImage) {
            frontImage = file
        }
        avgStars = gig.avgStars
        numOfReviews = gig.numOfReviews
        estimatedDuration = gig.estimatedDuration
    }
    
    override static func query() -> PFQuery<PFObject>? {
        let query = super.query()
        query?.whereKey("deleted", notEqualTo: true)
        return query
    }
}
