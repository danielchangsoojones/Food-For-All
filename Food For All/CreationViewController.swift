//
//  CreationViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func navBarSetup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(exitTapped))
    }
    
    func exitTapped() {
        self.navigationController?.dismissVC(completion: nil)
    }
}
