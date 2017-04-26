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
        let query = ContractParse.query()! as! PFQuery<ContractParse>
        query.whereKey("isCompleted", notEqualTo: true)
        
        let gigQuery = GigParse.query()!
        gigQuery.whereKey("creator", equalTo: User.current() ?? User())
        query.whereKey("gig", matchesQuery: gigQuery)
        
        //TODO: I am pulling down a lot of things and I shouldn't be pulling those down until they actually click a message, then I can load more. 
        query.includeKey("customer")
        query.includeKey("gig")
        query.includeKey("gig.creator")
        query.findObjectsInBackground { (contractParses, error) in
            if let contractParses = contractParses {
                let contracts = contractParses.map({ (c: ContractParse) -> Contract in
                    return Contract(contractParse: c)
                })
                self.delegate?.loaded(contracts: contracts)
            }
        }
    }
}
