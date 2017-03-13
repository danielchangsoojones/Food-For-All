//
//  CustomerScheduleDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 3/13/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation

class CustomerScheduleDataStore {
    func saveContract(gig: Gig, selectedTime: Date?) {
        let contractParse = ContractParse()
        contractParse.gig = gig.gigParse
        if let currentUser = User.current() {
            contractParse.customer = currentUser
        }
        contractParse.saveInBackground { (success, error) in
            contractParse.pinInBackground(block: { (success, error) in
                UserDefaults.standard.setValue(true, forKey: "doesContractExist")
                print("\(UserDefaults.standard.value(forKey: "doesContractExist")!)")
            })
        }
        
        
    }
}
