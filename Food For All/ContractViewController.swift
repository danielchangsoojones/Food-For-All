//
//  ContractViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 3/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ContractViewController: UIViewController {
    var theProfileCircleView: CircularImageView!
    var theTableView: UITableView!
    
    var messageHelper: MessageHelper?
    var contactHelper: ContactHelper?
    var contract: Contract?
    
    var contractView: ContractView {
        return ContractView(frame: self.view.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
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
    
    func contactUsTapped() {
        contactHelper = ContactHelper()
        contactHelper?.contactUs(currentVC: self)
    }
}
