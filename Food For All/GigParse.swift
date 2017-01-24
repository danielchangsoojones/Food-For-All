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
}
