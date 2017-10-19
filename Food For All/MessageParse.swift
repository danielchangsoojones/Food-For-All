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
}


