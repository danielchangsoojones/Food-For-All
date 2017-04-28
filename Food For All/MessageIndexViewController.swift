//
//  MessageIndexViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 4/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class MessageIndexViewController: UIViewController {
    var theTableView : UITableView!
    
    var contracts: [Contract] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        tableViewSetup()
        dataStoreSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarSetup()
    }
    
    fileprivate func viewSetup() {
        let messageIndexView = MessageIndexView(frame: self.view.bounds)
        self.view = messageIndexView
        theTableView = messageIndexView.theTableView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func navBarSetup() {
        if let navController = navigationController as? ClearNavigationController {
            navController.change(color: CustomColors.JellyTeal)
            //Must set title of the navigationItem instead of VC or else the tab bar has the title on it.
            self.navigationItem.title = "Message History"
        }
    }
    
    fileprivate func dataStoreSetup() {
        let dataStore = MessageIndexDataStore(delegate: self)
        dataStore.loadMessages()
    }
}

extension MessageIndexViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func tableViewSetup() {
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.register(CustomerMessageTableViewCell.self, forCellReuseIdentifier: CustomerMessageTableViewCell.identifier)
        theTableView.register(FreelancerMessageTableViewCell.self, forCellReuseIdentifier: FreelancerMessageTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contracts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contract = contracts[indexPath.row]
        var cell: MessageTableViewCell!
        if contract.currentUserIsCustomer {
            cell = theTableView.dequeueReusableCell(withIdentifier: FreelancerMessageTableViewCell.identifier, for: indexPath) as! FreelancerMessageTableViewCell
        } else {
            //current user is the freelancer, so show customer profile
            cell = theTableView.dequeueReusableCell(withIdentifier: CustomerMessageTableViewCell.identifier, for: indexPath) as! CustomerMessageTableViewCell
        }
        
        cell.setContents(contract: contract)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contract = contracts[indexPath.row]
        
        var contractVC: ContractViewController!
        if contract.currentUserIsCustomer {
            contractVC = FreelancerContractViewController()
        } else {
            //current user is the freelancer, so show information about the user
            contractVC = CustomerContractViewController()
        }
        contractVC.contract = contract
        pushVC(contractVC)
    }
}

extension MessageIndexViewController: MessageIndexDataStoreDelegate {
    func loaded(contracts: [Contract]) {
        self.contracts = contracts
        theTableView.reloadData()
    }
}
