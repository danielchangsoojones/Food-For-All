//
//  MessageIndexDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 4/26/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol MessageIndexDataStoreDelegate {
    func loaded(contracts: [Contract])
}

class MessageIndexDataStore {
    var delegate: MessageIndexDataStoreDelegate?
    
    init(delegate: MessageIndexDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func loadMessages() {
        let customerQuery = ContractParse.query()!
        customerQuery.whereKey("isCompleted", notEqualTo: true)
        
        let gigQuery = GigParse.query()!
        gigQuery.whereKey("creator", equalTo: User.current() ?? User())
        customerQuery.whereKey("gig", matchesQuery: gigQuery)
        
        let freelancerQuery = ContractParse.query()!
        freelancerQuery.whereKey("isCompleted", notEqualTo: true)
        freelancerQuery.whereKey("customer", equalTo: User.current() ?? User())
        
        //TODO: I am pulling down a lot of things and I shouldn't be pulling those down until they actually click a message, then I can load more. 
        let orQuery = PFQuery.orQuery(withSubqueries: [customerQuery, freelancerQuery])
        orQuery.includeKey("customer")
        orQuery.includeKey("gig")
        orQuery.includeKey("gig.creator")
        orQuery.order(byDescending: "updatedAt")
        orQuery.cachePolicy = .cacheThenNetwork
        orQuery.findObjectsInBackground { (contractParses, error) in
            if let contractParses = contractParses as? [ContractParse] {
                let contracts = contractParses.map({ (c: ContractParse) -> Contract in
                    return Contract(contractParse: c)
                })
                self.delegate?.loaded(contracts: contracts)
            }
        }
    }
}
