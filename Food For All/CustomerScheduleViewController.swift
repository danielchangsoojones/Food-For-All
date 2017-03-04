//
//  CustomerScheduleViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 3/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CustomerScheduleViewController: SchedulingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func eventCellPressed(indexPath: IndexPath) {
        print("event presssed")
    }
    
    fileprivate func navBarSetup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "skip", style: .plain, target: self, action: #selector(skipPressed))
    }
    
    func skipPressed() {
        Message(currentVC: self, gig: self.gig).send(type: .withoutTime)
    }
}
