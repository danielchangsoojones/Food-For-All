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
    
    var contractParse: ContractParse = ContractParse()
    
    init() {}
    
    init(contractParse: ContractParse) {
        self.contractParse = contractParse
        self.gig = Gig(gigParse: contractParse.gig)
        self.customer = contractParse.customer
    }
}
