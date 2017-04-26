//
//  Message.swift
//  Food For All
//
//  Created by Daniel Jones on 4/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Message {
    var sentDate: Date = Date()
    var messageMetric: MessageMetrics = MessageMetrics()
    
    init(messageMetric: MessageMetrics) {
        self.messageMetric = messageMetric
        self.sentDate = messageMetric.updatedAt ?? Date()
    }
}
