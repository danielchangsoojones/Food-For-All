//
//  ContractDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 3/13/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol ContractDataStoreDelegate {
    func loaded(contract: Contract)
}

class ContractDataStore {
    var delegate: ContractDataStoreDelegate?
    
    init(delegate: ContractDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func loadContract() {
        let query = ContractParse.query() as! PFQuery<ContractParse>
        query.fromLocalDatastore()
        query.getFirstObjectInBackground { (contractParse, error) in
            if let contractParse = contractParse {
                let contract = Contract(contractParse: contractParse)
                self.delegate?.loaded(contract: contract)
            } else if let error = error {
                print(error)
            }
        }
    }
    
    func delete(contract: Contract) {
        contract.contractParse.deleteInBackground()
        neverShowContractAgain(c: contract.contractParse)
    }
    
    func complete(contract: Contract) {
        let c = contract.contractParse
        c.isCompleted = true
        c.saveInBackground()
        neverShowContractAgain(c: c)
    }
    
    fileprivate func neverShowContractAgain(c: ContractParse) {
        //remove the contractParse from the phone, so it won't show the contract screen again.
        //TODO: If they have two contracts, then this would tell the userdefaults that it should never show again, even if they only deleted one.
        c.unpinInBackground()
        UserDefaults.standard.removeObject(forKey: ContractViewController.Constants.contractKey)
    }
}
