//
//  TransactionFeedViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import AMScrollingNavbar

class TransactionFeedViewController: UIViewController {
    var theTableView: UITableView!
    var theSpinnerView: UIView?
    var theSearchView: MainSearchView!
    
    var transactions: [Review] = []
    var dataStore: TransactionFeedDataStore?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        tableViewSetup()
        dataStoreSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(theTableView, delay: 20.0)
        }
        navBarSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.showNavbar(animated: true)
        }
    }
    
    fileprivate func viewSetup() {
        let transactionView = TransactionFeedView(frame: self.view.bounds)
        self.view = transactionView
        theTableView = transactionView.theTableView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = TransactionFeedDataStore(delegate: self)
        dataStore?.loadTransactions()
    }
}

extension TransactionFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableViewSetup() {
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return transactions.count
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.reuseIdentifier) as! TransactionTableViewCell
//        cell.setContents(review: transactions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let gig = transactions[indexPath.row].gig {
            theSpinnerView = Helpers.showActivityIndicatory(uiView: self.view)
            dataStore?.load(gig: gig)
        }
    }
}

//empty state extension
extension TransactionFeedViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        if !transactions.isEmpty {
            tableView.backgroundView?.isHidden = true
            return 1
        } else {
            EmptyState.showEmptyGigsView(tableView: tableView, currentVC: self, action: #selector(createButtonPressed))
            return 0
        }
    }
    
    func createButtonPressed() {
        CreationViewController.show(from: self)
    }
}

extension TransactionFeedViewController: TransactionFeedDataStoreDelegate {
    func loaded(transactions: [Review]) {
        self.transactions = transactions
        theTableView.reloadData()
    }
    
    func loaded(gigs: [Gig], tag: String) {
        let startingVC = FrontPageViewController()
        startingVC.gigs = gigs
        startingVC.title = tag
        theSpinnerView?.removeFromSuperview()
        pushVC(startingVC)
    }
    
    func loaded(gig: Gig) {
        let gigDetailVC = DetailViewController(gig: gig)
        pushVC(gigDetailVC)
    }
    
    func removeSpinner() {
        theSpinnerView?.removeFromSuperview()
    }
}
