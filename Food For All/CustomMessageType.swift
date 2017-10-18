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
    var sender: Sender {
        return Sender(id: User.current()?.objectId ?? randomString(), displayName: User.current()?.fullName ?? "Unknown")
    }
    
    var messageId: String {
        return randomString()
    }
    
    var sentDate: Date {
        return Date()
    }
    
    private var text: String = ""
    
    var data: MessageData {
        return MessageData.text(text)
    }
    
    init(text: String) {
        self.text = text
    }
    
    private func randomString() -> String {
        let length: Int = 10
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
