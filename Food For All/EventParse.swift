//
//  EventParse.swift
//  Food For All
//
//  Created by Daniel Jones on 3/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class EventParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "EventParse"
    }
    
    @NSManaged var start: Date
    @NSManaged var end: Date
    @NSManaged var creator: User
}
