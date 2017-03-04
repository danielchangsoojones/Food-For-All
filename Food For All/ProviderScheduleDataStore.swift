//
//  ProviderScheduleDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 3/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class ProviderScheduleDataStore {
    func save(event: CustomEvent) {
        let e = event.eventParse
        e.start = event.start
        e.end = event.end
        e.creator = User.current() ?? User()
        e.saveInBackground()
    }
    
    func delete(event: CustomEvent) {
        
    }
}
