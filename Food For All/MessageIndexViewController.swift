//
//  MessageIndexViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 4/18/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class MessageIndexViewController: UIViewController {
    var tableView : UITableView!
    
    var chatRooms: [ChatRoom] = []
    
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
        tableView = messageIndexView.theTableView
    }
    
    fileprivate func navBarSetup() {
        if let navController = navigationController as? ClearNavigationController {
            navController.change(color: CustomColors.JellyTeal)
            //Must set title of the navigationItem instead of VC or else the tab bar has the title on it.
            self.navigationItem.title = "Messages"
        }
    }
    
    fileprivate func dataStoreSetup() {
        let dataStore = MessageIndexDataStore(delegate: self)
        dataStore.loadMessages()
    }
}

extension MessageIndexViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func tableViewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if chatRooms.count > 0 {
            tableView.backgroundView = nil
            return 1
        } else {
            //TODO: delete this code, just for testing
//            let button = UIButton(frame: CGRect(x: 0, y: 0, w: 200, h: 200))
//            button.addTapGesture(action: { (tap) in
//                self.dataStoreSetup()
//            })
//            tableView.addSubview(button)
            
            
            Helpers.EmptyMessage(message: "No Messages", tableView: tableView)
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatRoom = chatRooms[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.identifier, for: indexPath) as! MessageTableViewCell
        cell.setContents(from: chatRoom)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoom = chatRooms[indexPath.row]
        let chatVC = ChatViewController(chatRoom: chatRoom)
        pushVC(chatVC)
    }
}

extension MessageIndexViewController: MessageIndexDataStoreDelegate {
    func loaded(_ chatRooms: [ChatRoom]) {
        self.chatRooms = chatRooms
        tableView.reloadData()
    }
}
