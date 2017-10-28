//
//  MessageParse.swift
//  Food For All
//
//  Created by Daniel Jones on 10/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class MessageParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "Message"
    }
    
    @NSManaged var chatRoom: ChatRoomParse    
    @NSManaged var text: String?
    @NSManaged var sender: User
    
    
    //need to save the objectId's because Parse Live Queries can't query pointers.
    @NSManaged var senderObjectId: String
    @NSManaged var chatRoomObjectId: String
}


