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

protocol FreelancersTableVCDelegate {
    func createButtonPressed()
}

class FreelancersTableViewController: UITableViewController {
    var gigs: [Gig] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var freelancerDelegate: FreelancersTableVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.register(FreelancersTableViewCell.self, forCellReuseIdentifier: FreelancersTableViewCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gigs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gig = gigs[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FreelancersTableViewCell.identifier) as! FreelancersTableViewCell
        cell.gig = gig

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FreelancersTableViewCell.Constants.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedGig = gigs[indexPath.row]
        let destinationVC = DetailViewController(gig: tappedGig)
        parent?.pushVC(destinationVC)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if gigs.count > 0 {
            return 1
        } else {
            EmptyState.showEmptyGigsView(tableView: tableView, currentVC: self, action: #selector(createButtonPressed))
            return 0
        }
    }
    
    func createButtonPressed() {
        freelancerDelegate?.createButtonPressed()
    }
}

extension FreelancersTableViewController {
    static func add(to parentVC: UIViewController, toView: UIView) -> FreelancersTableViewController {
        let tableVC = FreelancersTableViewController()
        if let childView = tableVC.view {
            parentVC.addChildViewController(tableVC)
            toView.addSubview(childView)
            tableVC.didMove(toParentViewController: parentVC)
            
            tableVC.view.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        return tableVC
    }
}
