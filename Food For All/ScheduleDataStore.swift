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
    
}

class ScheduleDataStore {
    var delegate: ScheduleDataStoreDelegate?
    
    init(delegate: ScheduleDataStoreDelegate) {
        
    }
}
