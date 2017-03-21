//
//  CustomerScheduleDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 3/13/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Mixpanel
import Alamofire

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
        sendContractToGroupMe(contract: contract)
    }
    
    fileprivate func sendContractToGroupMe(contract: Contract) {
        var configuration = Configuration()
        if configuration.environment == .Production {
            let url = "https://maker.ifttt.com/trigger/new-contract/with/key/bmku_IppapnZ3eewT54mzi"
            let fullName = User.current()?.fullName ?? ""
            let parameters: Parameters = ["value1" : fullName, "value2" : contract.gig.creator.fullName ?? "Unknown", "value3" : contract.gig.title]
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData(completionHandler: { (response) in
                print(response)
            })
        }
    }
}
