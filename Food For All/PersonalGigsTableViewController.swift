//
//  PersonalGigsTableViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class PersonalGigsTableViewController: FreelancersTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gig = gigs[indexPath.row]
        let cell = PersonalFreelancersTableViewCell(gig: gig, height: tableView.rowHeight)
        return cell
    }
}
