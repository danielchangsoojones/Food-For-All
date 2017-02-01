//
//  TimeIntervalHelper.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class TimeIntervalHelper {
    fileprivate var secondValue: Double = 1
    
    fileprivate var minuteValue: Double {
        return 60 * secondValue
    }
    
    fileprivate var hourValue: Double {
        return minuteValue * 60
    }
    
    fileprivate var dayValue: Double {
        return hourValue * 24
    }
    
    var timeInterval: TimeInterval = TimeInterval.leastNonzeroMagnitude
    
    init(seconds: Double = 0, minutes: Double = 0, hours: Double = 0, days: Double = 0) {
        let totalTime = seconds * secondValue + minutes * minuteValue + hours * hourValue + days * dayValue
        if let interval = TimeInterval(exactly: totalTime) {
            timeInterval =  interval
        }
    }
}
