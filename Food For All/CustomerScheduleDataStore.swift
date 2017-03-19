//
//  CustomerScheduleDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 3/13/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Mixpanel

class CustomerScheduleDataStore {
    func save(contract: Contract) {
        let contractParse = ContractParse(contract: contract)
        contractParse.saveInBackground { (success, error) in
            self.saveContractMetric(contract: contract)
            UserDefaults.standard.set(true, forKey: ContractViewController.Constants.contractKey)
        }
    }
    
    fileprivate func saveContractMetric(contract: Contract) {
        Mixpanel.mainInstance().track(event: "Contract", properties: ["status" : "in-progress", "freelancer" : contract.gig.creator.fullName ?? "Unknown"])
    }
}
