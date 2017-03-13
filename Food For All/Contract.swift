//
//  Contract.swift
//  Food For All
//
//  Created by Daniel Jones on 3/13/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class Contract {
    var gig: Gig = Gig()
    var plannedTime: Date?
    var customer: User = User.current()!
    
    init() {}
    
    init(contractParse: ContractParse) {
        self.gig = Gig(gigParse: contractParse.gig)
        self.plannedTime = contractParse.plannedTime
        self.customer = contractParse.customer
    }
}
