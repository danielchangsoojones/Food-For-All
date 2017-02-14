//
//  AllReviewsViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/11/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class AllReviewsViewController: UIViewController {
    var theTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        theTableView.estimatedRowHeight = 100.0
        theTableView.rowHeight = UITableViewAutomaticDimension
        leftBarButtonSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func viewSetup() {
        let allReviewsView = AllReviewsView(frame: self.view.bounds)
        self.view = allReviewsView
        theTableView = allReviewsView.theTableView
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.tableHeaderView = allReviewsView.theTableHeaderView
    }
}

//navigation bar extension
extension AllReviewsViewController {
    fileprivate func leftBarButtonSetup() {
        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "X"), style: .plain, target: self, action: #selector(exitTapped))
        navigationItem.leftBarButtonItem = barButton
    }
    
    func exitTapped() {
        popVC()
    }
}

extension AllReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentRow = indexPath.row
        
        let review = Review()
        review.description = "heyyy"
        review.stars = 2
        
        let cell = ReviewTableViewCell(review: review)
        
        return cell
    }
    
////    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return 100
////    }
//    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
