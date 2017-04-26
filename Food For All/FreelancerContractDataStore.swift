//
//  ContractDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 3/13/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Mixpanel

class FreelancerContractDataStore {
    init() {}
    
    func delete(contract: Contract) {
        //TODO: don't actually delete, just have it add a deleted field to the object.
        contract.contractParse.deleteInBackground()
        deleteContractMetric(contract: contract)
    }
    
    func complete(contract: Contract) {
        completeContractMetric(contract: contract)
        let c = contract.contractParse
        c.isCompleted = true
        c.saveInBackground()
    }
    
    fileprivate func deleteContractMetric(contract: Contract) {
        Mixpanel.mainInstance().track(event: "Contract", properties: ["status" : "deleted", "freelancer" : contract.gig.creator.fullName ?? "Unknown"])
    }
    
    fileprivate func completeContractMetric(contract: Contract) {
        Mixpanel.mainInstance().track(event: "Contract", properties: ["status" : "completed", "freelancer" : contract.gig.creator.fullName ?? "Unknown"])
    }
    
    func saveVenmoMetric(state: String, gig: Gig) {
        let metric = VenmoMetric()
        if let currentUser = User.current() {
            metric.customer = currentUser
            Mixpanel.mainInstance().track(event: "Venmo",
                                          properties: ["State" : state, "Gig" : gig.title, "Customer" : currentUser.fullName ?? ""])
        }
        metric.gig = gig.gigParse
        metric.state = state
        metric.saveInBackground()
    }
}
