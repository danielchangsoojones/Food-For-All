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
    
    var gig: Gig!
    var reviews: [Review] = []
    
    var dataStore: AllReviewsDataStore?
    
    init(gig: Gig) {
        super.init(nibName: nil, bundle: nil)
        self.gig = gig
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        tableViewSetup()
        navBarSetup()
        dataStoreSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
    
    //TODO: I want to turn the status bar black, but can't figure out how to do that yet.
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = AllReviewsDataStore(delegate: self, gig: gig)
    }
}

//navigation bar extension
extension AllReviewsViewController {
    fileprivate func navBarSetup() {
        if let navController = self.navigationController as? WelcomeNavigationController {
            navController.makeTransparent()
            navController.navigationBar.tintColor = UIColor.black
        }
        
        leftBarButtonSetup()
        rightBarButtonSetup()
    }
    
    fileprivate func leftBarButtonSetup() {
        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "X"), style: .plain, target: self, action: #selector(exitTapped))
        navigationItem.leftBarButtonItem = barButton
    }
    
    func exitTapped() {
        if let navController = self.navigationController as? WelcomeNavigationController {
            navController.resetToDefaults()
        }
        popVC()
    }
    
    fileprivate func rightBarButtonSetup() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewReview))
        navigationItem.rightBarButtonItem = barButton
    }
    
    func createNewReview() {
        let newRatingVC = NewRatingViewController(gig: gig)
        newRatingVC.delegate = self
        pushVC(newRatingVC)
    }
}

extension AllReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func tableViewSetup() {
        theTableView.tableFooterView = UIView() //makes it so no empty cells get shown
        theTableView.estimatedRowHeight = 100.0
        theTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let review = reviews[indexPath.row]
        if review.creator == Person.current() {
            let cell = PersonalReviewTableViewCell(review: review)
            return cell
        } else {
            //not created by the current user, so just make a normal cell
            let cell = ReviewTableViewCell(review: review)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let review = reviews[indexPath.row]
        if review.creator == Person.current() {
            segueToEditRatingVC(review: review)
        }
    }
    
    fileprivate func segueToEditRatingVC(review: Review) {
        let editingVC = EditingRatingViewController(gig: gig, review: review)
        editingVC.editDelegate = self
        pushVC(editingVC)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if reviews.isEmpty {
            Helpers.EmptyMessage(message: "No Reviews Yet", tableView: theTableView)
            return 0
        } else {
            tableView.backgroundView = nil
            return 1
        }
    }
}

extension AllReviewsViewController: NewRatingVCDelegate, EditRatingVCDelegate {
    func add(review: Review) {
        self.reviews.insertAsFirst(review)
        theTableView.reloadData()
    }
    
    func update(review: Review) {
        let index: Int? = reviews.index(where: { (r: Review) -> Bool in
            return r == review
        })
        if let index = index {
            //move the review to the top
            reviews.remove(at: index)
            add(review: review)
        }
    }
    
    func remove(review: Review) {
        
    }
}

extension AllReviewsViewController: AllReviewsDataStoreDelegate {
    func loaded(reviews: [Review]) {
        self.reviews = reviews
        theTableView.reloadData()
    }
}
