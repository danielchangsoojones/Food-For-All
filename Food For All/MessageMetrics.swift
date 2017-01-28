//
//  MessageMetrics.swift
//  Food For All
//
//  Created by Daniel Jones on 1/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class MessageMetrics: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "MessageMetrics"
    }
    
    @NSManaged var gig: GigParse
    @NSManaged var customer: User
    @NSManaged var state: String
}
