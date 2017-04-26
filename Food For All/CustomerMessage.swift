//
//  CustomerMessage.swift
//  Food For All
//
//  Created by Daniel Jones on 4/26/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class CustomerMessage: Message {
    var freelancer: User = User.current() ?? User()
    var customer: User = User()
    
    override init(messageMetric: MessageMetrics) {
        super.init(messageMetric: messageMetric)
        self.customer = messageMetric.customer
    }
}
