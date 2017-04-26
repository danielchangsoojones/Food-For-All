//
//  MessageIndexViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 4/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class MessageIndexViewController: UIViewController {
    var theTableView : UITableView!
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        tableViewSetup()
        dataStoreSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarSetup()
    }
    
    fileprivate func viewSetup() {
        let messageIndexView = MessageIndexView(frame: self.view.bounds)
        self.view = messageIndexView
        theTableView = messageIndexView.theTableView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func navBarSetup() {
        if let navController = navigationController as? ClearNavigationController {
            navController.change(color: CustomColors.JellyTeal)
            //Must set title of the navigationItem instead of VC or else the tab bar has the title on it.
            self.navigationItem.title = "Message History"
        }
    }
    
    fileprivate func dataStoreSetup() {
        let dataStore = MessageIndexDataStore(delegate: self)
        dataStore.loadMessages()
    }
}

extension MessageIndexViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func tableViewSetup() {
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.register(CustomerMessageTableViewCell.self, forCellReuseIdentifier: CustomerMessageTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = theTableView.dequeueReusableCell(withIdentifier: CustomerMessageTableViewCell.identifier, for: indexPath)
        return cell
    }
}

extension MessageIndexViewController: MessageIndexDataStoreDelegate {
    func loaded(messages: [Message]) {
        self.messages = messages
        theTableView.reloadData()
    }
}
