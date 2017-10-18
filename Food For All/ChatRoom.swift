//
//  ChatRoom.swift
//  Food For All
//
//  Created by Daniel Jones on 10/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class ChatRoom {
    var freelancer: User {
        get {
            return gig.creator
        }
    }
    var consumer: User!
    var gig: Gig!
    
    var otherUser: User {
        get {
            if consumer.objectId == User.current()?.objectId {
                return freelancer
            } else {
                return consumer
            }
        }
    }
    
    init(gig: Gig, consumer: User) {
        self.gig = gig
        self.consumer = consumer
    }
}
