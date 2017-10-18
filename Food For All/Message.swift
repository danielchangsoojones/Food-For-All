//
//  Message.swift
//  Food For All
//
//  Created by Daniel Jones on 10/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Message {
    var text: String?
    var sentDate: Date = Date()
    
    init(text: String, sentDate: Date) {
        self.text = text
        self.dateSent = dateSent
    }
}
