//
//  MainSearchingViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class MainSearchingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navBarSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

//navigation bar extension
extension MainSearchingViewController {
    fileprivate func navBarSetup() {
        if let customNav = self.navigationController as? CustomNavigationController {
            customNav.makeTransparent()
        }
        leftBarButtonSetup()
    }
    
    fileprivate func leftBarButtonSetup() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "X"), style: .done, target: self, action: #selector(leftBarButtonTapped))
    }
    
    func leftBarButtonTapped() {
        popVC()
    }
}
