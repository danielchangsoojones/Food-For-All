//
//  Message.swift
//  Food For All
//
//  Created by Daniel Jones on 10/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Message {
    var text: String? {
        get {
            return messageParse?.text
        }
        set {
            if messageParse == nil {
                messageParse = MessageParse()
                messageParse?.text = newValue
            }
        }
    }
    var sentDate: Date {
        return messageParse?.createdAt ?? Date()
    }
    
    var messageType = CustomMessageType()
    
    var sender: User {
        return messageParse?.sender ?? User()
    }
    
    var messageParse: MessageParse?
    
    init(messageParse: MessageParse) {
        self.messageParse = messageParse
    }
    
    init(text: String) {
        self.text = text
    }
}
