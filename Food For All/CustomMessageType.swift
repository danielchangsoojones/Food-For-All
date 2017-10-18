//
//  CustomMessageType.swift
//  Food For All
//
//  Created by Daniel Jones on 10/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import MessageKit

class CustomMessageType: MessageType {
    private var _sender: Sender!
    var sender: Sender {
        return _sender
    }
    
    var messageId: String {
        return Helpers.randomString(length: 10)
    }
    
    var sentDate: Date {
        return Date()
    }
    
    private var text: String = ""
    
    var data: MessageData {
        return MessageData.text(text)
    }
    
    init(text: String, sender: Sender) {
        self.text = text
        self._sender = sender
    }
}
