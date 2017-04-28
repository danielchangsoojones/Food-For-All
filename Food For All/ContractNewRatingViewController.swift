//
//  ContractNewRatingViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 3/15/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ContractNewRatingViewController: NewRatingViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        skipButtonSetup()
        navBar?.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func skipButtonSetup() {
        let skipButton = UIBarButtonItem(title: "skip", style: .plain, target: self, action: #selector(skipPressed))
        navigationItem.rightBarButtonItem = skipButton
    }
    
    func skipPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func finishedSaving(review: Review) {
        navigationController?.popToRootViewController(animated: true)
    }
}
