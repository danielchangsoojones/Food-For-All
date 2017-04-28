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
    var customer: User = User.current()!
    var sentDate: Date = Date()
    
    var contractParse: ContractParse = ContractParse()
    
    init() {}
    
    init(contractParse: ContractParse) {
        self.contractParse = contractParse
        self.gig = Gig(gigParse: contractParse.gig)
        self.customer = contractParse.customer
        self.sentDate = contractParse.updatedAt ?? Date()
    }
    
    var currentUserIsCustomer: Bool {
        //For some reason, just comparing the users is not working
        return customer.objectId == User.current()?.objectId
    }
}
