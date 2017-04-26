//
//  ContractViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 3/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ContractViewController: UIViewController {
    struct Constants {
        static let contractKey = "doesContractExist"
    }
    
    var theProfileCircleView: CircularImageView!
    var theTableView: UITableView!
    
    var messageHelper: MessageHelper?
    var dataStore: ContractDataStore?
    var contactHelper: ContactHelper?
    
    var contractView: ContractView {
        return ContractView(frame: self.view.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        dataStoreSetup()
        if let contract = contract {
            //load the contract
            setContent(contract: contract)
        } else {
            dataStore?.loadContract()
        }
    }
    
    func viewSetup() {
        let contractView = self.contractView
        self.view = contractView
        theTableView = contractView.theTableView
        theProfileCircleView = contractView.theProfileCircleView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = ContractDataStore(delegate: self)
    }
}
