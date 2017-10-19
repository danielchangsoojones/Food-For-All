//
//  ChatRoomParse.swift
//  Food For All
//
//  Created by Daniel Jones on 10/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class ChatRoomParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "ChatRoom"
    }
    
    @NSManaged var consumer: User
    @NSManaged var gig: GigParse
    
    override init() {
        super.init()
    }
    
    init(gig: GigParse, consumer: User) {
        super.init()
        self.consumer = consumer
        self.gig = gig
    }
}
