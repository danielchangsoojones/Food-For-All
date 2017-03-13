//
//  ContractParse.swift
//  Food For All
//
//  Created by Daniel Jones on 3/13/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

class ContractParse: PFObject, PFSubclassing {
    class func parseClassName() -> String {
        return "ContractParse"
    }
    
    @NSManaged var gig: GigParse
    @NSManaged var plannedTime: Date?
    @NSManaged var customer: User
    
    override init() {
        super.init()
    }
    
    init(contract: Contract) {
        super.init()
        self.gig = contract.gig.gigParse
        self.plannedTime = contract.plannedTime
        self.customer = contract.customer
    }
}
