//
//  Enviroment.swift
//  Food For All
//
//  Created by Daniel Jones on 1/11/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

enum Environment: String {
    case Staging = "staging"
    case Production = "production"
    
    //TODO: set up production config stuff
    var applicationId: String {
        switch self {
        case .Staging: return "foodforalldevelopment657492394LKASDJFKLASJ"
        case .Production: return "still need to set up"
        }
    }
    
    var server: String {
        switch self {
        case .Staging: return "http://foodforalldevelopment.herokuapp.com/parse"
        case .Production: return "still need to set up"
        }
    }
}
