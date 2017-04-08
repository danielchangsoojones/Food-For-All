//
//  TransactionFeedViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class TransactionFeedViewController: UIViewController {
    var theTableView: UITableView!
    
    var transactions: [Review] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        tableViewSetup()
        dataStoreSetup()
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
        let dataStore = TransactionFeedDataStore(delegate: self)
        dataStore.loadTransactions()
    }
}

extension TransactionFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableViewSetup() {
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.reuseIdentifier) as! TransactionTableViewCell
        cell.setContents(review: transactions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension TransactionFeedViewController: TransactionFeedDataStoreDelegate {
    func loaded(transactions reviews: [Review]) {
        self.transactions = reviews
        theTableView.reloadData()
    }
}
