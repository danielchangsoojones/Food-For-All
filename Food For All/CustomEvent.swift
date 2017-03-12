//
//  CustomEvent.swift
//  Food For All
//
//  Created by Daniel Jones on 3/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class CustomEvent {
    var start: Date
    var end: Date
    var isNew: Bool = false
    var eventParse: EventParse = EventParse()
    
    init(start: Date, end: Date) {
        self.start = start
        self.end = end
    }
    
    convenience init(eventParse: EventParse) {
        self.init(start: eventParse.start, end: eventParse.end)
        self.eventParse = eventParse
    }
}
