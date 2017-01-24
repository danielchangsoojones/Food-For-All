//
//  FreelancersTableViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import SnapKit

class FreelancersTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = Person()
        let gig = Gig(title: "K201 Tutoring", price: 15, description: "hi", creator: person)
        let cell = FreelancersTableViewCell(gig: gig, height: tableView.rowHeight)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.rowHeight = 100
        return tableView.rowHeight
    }
}

extension FreelancersTableViewController {
    static func add(to parentVC: UIViewController, toView: UIView) {
        let tableVC = FreelancersTableViewController()
        if let childView = tableVC.view {
            parentVC.addChildViewController(tableVC)
            toView.addSubview(childView)
            tableVC.didMove(toParentViewController: parentVC)
            
            tableVC.view.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }
}
