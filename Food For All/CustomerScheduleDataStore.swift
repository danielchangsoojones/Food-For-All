//
//  CustomerScheduleDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 3/13/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class CustomerScheduleDataStore {
    func save(contract: Contract) {
        let contractParse = ContractParse(contract: contract)
        contractParse.saveInBackground { (success, error) in
            contractParse.pinInBackground(block: { (success, error) in
                UserDefaults.standard.set(true, forKey: ContractViewController.Constants.contractKey)
            })
        }
    }
}
