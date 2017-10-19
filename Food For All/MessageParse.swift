//
//  MessageParse.swift
//  Food For All
//
//  Created by Daniel Jones on 10/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class MessageParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "Message"
    }
    
    @NSManaged var chatRoom: ChatRoom
    @NSManaged var 
    
    override init() {
        super.init()
    }
    
    init(review: Review) {
        super.init()
        self.creator = review.creator
        self.detail = review.description
        self.stars = review.stars
        self.title = review.title
        if let gig = review.gig {
            let g = gig.gigParse
            self.gig = g
        }
    }
}


