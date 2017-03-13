//
//  ContractViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 3/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ContractViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        navBarSetup()
    }
    
    fileprivate func viewSetup() {
        let contractView = ContractView(frame: self.view.bounds)
        self.view = contractView
        contractView.theTableView.delegate = self
        contractView.theTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension ContractViewController {
    fileprivate func navBarSetup() {
        setNavBarTitle()
        addHomeButton()
    }
    
    fileprivate func setNavBarTitle() {
        navigationItem.title = "Transaction"
    }
    
    fileprivate func addHomeButton() {
        //need to make sure button has a specific size
        let homeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        homeButton.setBackgroundImage(#imageLiteral(resourceName: "home-1"), for: .normal)
        homeButton.addTarget(self, action: #selector(homePressed), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: homeButton)
    }
    
    func homePressed() {
        //enter app
    }
}

extension ContractViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Contract.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contract = Contract(rawValue: indexPath.row) ?? .description
        let data = ContractCellData()
        switch contract {
        case .description:
            return data.createDescriptionCell(gig: Gig())
        case .message:
            return data.createMessageCell()
        case .venmo:
            return data.createVenmoCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CreationViewController.Constants.cellHeight
    }
}
