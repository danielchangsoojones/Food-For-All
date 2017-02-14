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
    
    var reviews: [Review] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        leftBarButtonSetup()
        tableViewSetup()
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
    fileprivate func tableViewSetup() {
        theTableView.tableFooterView = UIView() //makes it so no empty cells get shown
        theTableView.estimatedRowHeight = 100.0
        theTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentRow = indexPath.row
        
        let review = Review()
        review.description = "Bacon ipsum dolor amet turkey beef tenderloin tongue, pork capicola flank. Turducken frankfurter meatball ribeye, bacon shankle ground round kielbasa. Sausage rump frankfurter, chicken landjaeger shoulder salami t-bone ball tip bacon meatball. Short ribs tri-tip pork loin prosciutto sirloin, brisket spare ribs frankfurter tongue bresaola boudin picanha. Salami ribeye shank, cupim pork belly brisket sausage ground round pig tri-tip picanha capicola tail ham hock doner. Turducken chicken ground round tenderloin doner leberkas. Brisket pig shank ball tip spare ribs."
        review.stars = 2
        
        let cell = ReviewTableViewCell(review: review)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        //TODO: commented out for testing purposes
//        if reviews.isEmpty {
//            Helpers.EmptyMessage(message: "No Reviews Yet", tableView: theTableView)
//            return 0
//        } else {
//            return 1
//        }
        return 1
    }
}
