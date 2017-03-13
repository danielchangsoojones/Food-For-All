//
//  ContractViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 3/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ContractViewController: UIViewController {
    var gig: Gig?
    var messageHelper: MessageHelper?
    
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
        Helpers.enterApplication(from: self)
    }
}

extension ContractViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContractCell.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contract = ContractCell(rawValue: indexPath.row) ?? .description
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
        let contract = ContractCell(rawValue: indexPath.row) ?? .message
        switch contract {
        case .description:
            return 150
        default:
            return CreationViewController.Constants.cellHeight
        }
    }
}

//cell actions
extension ContractViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contract = ContractCell(rawValue: indexPath.row) ?? .description
        switch contract {
        case .message:
            messageTapped()
        case .venmo:
            venmoTapped()
        default:
            break
        }
    }
    
    fileprivate func messageTapped() {
        if let gig = gig {
            messageHelper = MessageHelper(currentVC: self, gig: gig)
            messageHelper?.send(type: .blank)
        }
    }
    
    fileprivate func venmoTapped() {
        let venmoUsername: String? = gig?.creator.venmoUsername
        let headURL = "https://venmo.com/"
        
        var venmoState: String = "pressed, but no venmo account attatched"
        if let venmoUsername = venmoUsername {
            if let destinationURL = URL(string: headURL + venmoUsername) {
                UIApplication.shared.openURL(destinationURL)
            } else {
                Helpers.showBanner(title: "Error", subtitle: "Venmo could not be loaded", bannerType: .error)
            }
            venmoState = "success"
        } else {
            //the gig creator never made a username
            Helpers.showBanner(title: "Error", subtitle: "The freelancer has not configured their venmo account yet", bannerType: .error)
        }
        
//        dataStore.saveVenmoMetric(state: venmoState, gig: gig)
    }
}
