//
//  ContractDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 3/13/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import Mixpanel

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
        query.whereKey("customer", equalTo: User.current() ?? User())
        query.whereKey("isCompleted", notEqualTo: true)
        query.order(byDescending: "createdAt")
        query.includeKey("gig")
        query.includeKey("gig.creator")
        
        //TODO: this is not perfect, we should be saving the object to the local data store, and then we can pull it up. This will bring up the past contract for a second, before it reloads with the new one.
        query.cachePolicy = .cacheThenNetwork
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
        deleteContractMetric(contract: contract)
    }
    
    func complete(contract: Contract) {
        completeContractMetric(contract: contract)
        let c = contract.contractParse
        c.isCompleted = true
        c.saveInBackground()
        neverShowContractAgain(c: c)
    }
    
    fileprivate func neverShowContractAgain(c: ContractParse) {
        UserDefaults.standard.removeObject(forKey: ContractViewController.Constants.contractKey)
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
