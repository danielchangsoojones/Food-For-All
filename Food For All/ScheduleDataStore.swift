//
//  ScheduleDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 3/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol ScheduleDataStoreDelegate {
    func loaded(events: [CustomEvent])
}

class ScheduleDataStore {
    var delegate: ScheduleDataStoreDelegate?
    
    init(delegate: ScheduleDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func load(from gig: Gig) {
        let query = EventParse.query()! as! PFQuery<EventParse>
        query.whereKey("creator", equalTo: gig.creator)
        query.findObjectsInBackground { (eventParses, error) in
            if let eventParses = eventParses {
                let events: [CustomEvent] = eventParses.map({ (e: EventParse) -> CustomEvent in
                    return CustomEvent(eventParse: e)
                })
                self.delegate?.loaded(events: events)
            } else if let error = error {
                print(error)
            }
        }
    }
}
