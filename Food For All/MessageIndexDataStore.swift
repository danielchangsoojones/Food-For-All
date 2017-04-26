//
//  MessageIndexDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 4/26/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol MessageIndexDataStoreDelegate {
    func loaded(messages: [Message])
}

class MessageIndexDataStore {
    var delegate: MessageIndexDataStoreDelegate?
    
    init(delegate: MessageIndexDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func loadMessages() {
        let query = MessageMetrics.query()! as! PFQuery<MessageMetrics>
        query.whereKey("state", equalTo: "successfully sent")
        
        let gigQuery = GigParse.query()!
        gigQuery.whereKey("creator", equalTo: User.current() ?? User())
        query.whereKey("gig", matchesQuery: gigQuery)
        
        query.includeKey("customer")
        query.findObjectsInBackground { (messageMetrics, error) in
            if let messageMetrics = messageMetrics {
                let messages = messageMetrics.map({ (m: MessageMetrics) -> Message in
                    if m.customer != User.current() {
                        //the current User is the freelancer the message was sent to
                        return CustomerMessage(messageMetric: m)
                    } else {
                        return Message(messageMetric: m)
                    }
                })
                self.delegate?.loaded(messages: messages)
            }
        }
    }
}
