//
//  SuperCreationFormViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Former

class SuperCreationFormViewController: UIViewController {
    let tableView: UITableView = UITableView(frame: CGRect.zero, style: .grouped)
    lazy var former: Former = Former(tableView: self.tableView)
    
    var gig: Gig?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        navBar?.backgroundColor = CustomColors.AquamarineBlue
        rightBarButtonItemSetup()
    }
    
    override var prefersStatusBarHidden: Bool {
        //TODO: for some reason, the nav bar background color will only cover the navigation bar, but not the status bar background. Haven't figured out how to fix, so just hiding the status bar here until I figure out what is going on.
        return true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableViewSetup() {
        tableView.frame = self.view.bounds
        self.view.addSubview(tableView)
    }
    
    func save(sender: UIBarButtonItem) {
    }
}

extension SuperCreationFormViewController {
    fileprivate func rightBarButtonItemSetup() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save(sender:)))
        self.navigationItem.rightBarButtonItem = saveButton
    }
}
