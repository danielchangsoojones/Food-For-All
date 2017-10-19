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
        return messageParse?.text
    }
    var sentDate: Date {
        return messageParse?.createdAt ?? Date()
    }
    
    var messageParse: MessageParse?
    
    init(messageParse: MessageParse) {
        self.messageParse = messageParse
    }
}
