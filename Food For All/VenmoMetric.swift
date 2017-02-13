//
//  VenmoMetric.swift
//  Food For All
//
//  Created by Daniel Jones on 2/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class VenmoMetric: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "VenmoMetric"
    }
    
    @NSManaged var gig: GigParse
    @NSManaged var customer: User
    @NSManaged var state: String
}
