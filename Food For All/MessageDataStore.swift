//
//  MessageDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 3/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class MessageDataStore {
    func saveMessageMetric(messageState: String, gig: Gig) {
        let metric = MessageMetrics()
        if let currentUser = User.current() {
            metric.customer = currentUser
        }
        metric.gig = gig.gigParse
        metric.state = messageState
        metric.saveInBackground()
    }
}
