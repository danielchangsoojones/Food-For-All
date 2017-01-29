//
//  SearchGig.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class SearchGig: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "SearchGig"
    }
    
    @NSManaged var lowercasedTitle: String
    @NSManaged var gigParse: GigParse
}
