//
//  FreelancerContractViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 4/26/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class FreelancerContractViewController: ContractViewController {
    override var contractView: ContractView {
        return FreelancerContractView(frame: self.view.bounds)
    }
    
    var dataStore: FreelancerContractDataStore?

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarTitle()
        dataStoreSetup()
        setContent(contract: contract)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewSetup() {
        super.viewSetup()
        theTableView.delegate = self
        theTableView.dataSource = self
        if let contractView = view as? FreelancerContractView {
            contractView.theCompleteButtonView.addTapGesture(target: self, action: #selector(completedTapped))
            contractView.theDeleteButtonView.addTapGesture(target: self, action: #selector(deleteTapped))
        }
    }
    
    func setContent(contract: Contract?) {
        if let contract = contract {
            theProfileCircleView.add(file: contract.gig.creator.profileImage)
        }
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = FreelancerContractDataStore()
    }
}

extension FreelancerContractViewController {
    fileprivate func setNavBarTitle() {
        navigationItem.title = "Freelancer"
    }
}

extension FreelancerContractViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContractCell.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = ContractCell(rawValue: indexPath.row) ?? .description
        let data = ContractCellData()
        var cell: UITableViewCell!
        switch cellType {
        case .description:
            cell = data.createDescriptionCell(contract: self.contract)
        case .message:
            cell = data.createMessageCell()
        case .venmo:
            cell = data.createVenmoCell()
        case .contactUs:
            cell = data.createContactUsCell()
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let contract = ContractCell(rawValue: indexPath.row) ?? .message
        switch contract {
        case .description:
            return UITableViewAutomaticDimension
        default:
            return CreationViewController.Constants.cellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

//cell actions
extension FreelancerContractViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contract = ContractCell(rawValue: indexPath.row) ?? .description
        switch contract {
        case .message:
            messageTapped()
        case .venmo:
            venmoTapped()
        case .contactUs:
            contactUsTapped()
        default:
            break
        }
    }
    
    fileprivate func messageTapped() {
        if let gig = contract?.gig {
            messageHelper = MessageHelper(currentVC: self, gig: gig)
            messageHelper?.show()
        }
    }
    
    fileprivate func venmoTapped() {
        if let gig = contract?.gig {
            Helpers.venmoTapped(gig: gig)
        }
    }
    
    func completedTapped() {
        if let contract = contract {
            dataStore?.complete(contract: contract)
            let newReviewVC = ContractNewRatingViewController(gig: contract.gig)
            pushVC(newReviewVC)
        }
    }
    
    func deleteTapped() {
        if let contract = contract {
            dataStore?.delete(contract: contract)
        }
        popVC()
    }
}
