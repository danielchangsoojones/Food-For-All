//
//  ContractViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 3/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ContractViewController: UIViewController {
    struct Constants {
        static let contractKey = "doesContractExist"
    }
    
    var theProfileCircleView: CircularImageView!
    var theTableView: UITableView!
    
    var contract: Contract?
    var messageHelper: MessageHelper?
    var dataStore: ContractDataStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        navBarSetup()
        dataStoreSetup()
        if let contract = contract {
            //load the contract
            setContent(contract: contract)
        } else {
            dataStore?.loadContract()
        }
    }
    
    fileprivate func viewSetup() {
        let contractView = ContractView(frame: self.view.bounds)
        self.view = contractView
        theTableView = contractView.theTableView
        contractView.theTableView.delegate = self
        contractView.theTableView.dataSource = self
        theProfileCircleView = contractView.theProfileCircleView
        contractView.theCompleteButtonView.addTapGesture(target: self, action: #selector(completedTapped))
        contractView.theDeleteButtonView.addTapGesture(target: self, action: #selector(deleteTapped))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setContent(contract: Contract) {
        theProfileCircleView.add(file: contract.gig.creator.profileImage)
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = ContractDataStore(delegate: self)
    }
}

extension ContractViewController {
    fileprivate func navBarSetup() {
        setNavBarTitle()
        addHomeButton()
    }
    
    fileprivate func setNavBarTitle() {
        navigationItem.title = "Pending Transaction"
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
        let cellType = ContractCell(rawValue: indexPath.row) ?? .description
        let data = ContractCellData()
        switch cellType {
        case .description:
            return data.createDescriptionCell(contract: self.contract)
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
            return 120
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
        if let gig = contract?.gig {
            messageHelper = MessageHelper(currentVC: self, gig: gig)
            messageHelper?.send(type: .blank)
        }
    }
    
    fileprivate func venmoTapped() {
        let venmoUsername: String? = contract?.gig.creator.venmoUsername
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
        
        if let gig = contract?.gig {
            dataStore?.saveVenmoMetric(state: venmoState, gig: gig)
        }
    }
    
    func completedTapped() {
        if let contract = contract {
            dataStore?.complete(contract: contract)
        }
        //TODO: move to the review page
        Helpers.enterApplication(from: self)
    }
    
    func deleteTapped() {
        if let contract = contract {
            dataStore?.delete(contract: contract)
        }
        Helpers.enterApplication(from: self)
    }
}

extension ContractViewController: ContractDataStoreDelegate {
    func loaded(contract: Contract) {
        self.contract = contract
        setContent(contract: contract)
        theTableView.reloadData()
    }
}
