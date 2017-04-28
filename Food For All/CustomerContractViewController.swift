//
//  CustomerContractViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 4/26/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

class CustomerContractViewController: ContractViewController {
    enum CustomerContractCell: Int {
        case description
        case mutualFriends
        case contactAdmin
        
        static let all: [CustomerContractCell] = [.description, .mutualFriends, .contactAdmin]
        static func insertInto(array: [CustomerContractCell], type: CustomerContractCell) -> [CustomerContractCell] {
            var arrayCopy = array
            let targetIndex = array.index { (item: CustomerContractCell) -> Bool in
                return item.rawValue > type.rawValue
            }
            
            if let targetIndex = targetIndex {
                arrayCopy.insert(type, at: targetIndex)
            }
            
            return arrayCopy
        }
    }
    
    var dataStore: CustomerContractDataStore?
    var totalMutualFriends: Int = 0
    var mutualFriends: [MutualFriend] = []
    var cellData: [CustomerContractCell] = [.description, .contactAdmin]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStoreSetup()
        tableViewSetup()
        setContents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navController = navigationController as? ClearNavigationController {
            navController.makeTransparent()
        }
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = CustomerContractDataStore(delegate: self)
    }
}

extension CustomerContractViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func setContents() {
        if let customer = contract?.customer {
            theProfileCircleView.add(file: customer.profileImage)
            dataStore?.loadMutualFriends(targetUser: customer)
        }
    }
    
    fileprivate func tableViewSetup() {
        theTableView.delegate = self
        theTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = cellData[indexPath.row]
        switch cellType {
        case .description:
            return UITableViewAutomaticDimension
        case .mutualFriends:
            return 155
        default:
            return CreationViewController.Constants.cellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension CustomerContractViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = cellData[indexPath.row]
        var cell: UITableViewCell!
        switch cellType {
        case .description:
            cell = createDescriptionCell()
        case .mutualFriends:
            cell = createMutualFriendCell()
        case .contactAdmin:
            cell = createContactAdminCell()
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    fileprivate func createDescriptionCell() -> UITableViewCell {
        let cell = ContractTableViewCell(style: .default, reuseIdentifier: nil)
        if let customer = contract?.customer {
            //TODO: add other bio information like school/job ect.
            cell.theTitleLabel.text = customer.fullName
        }
        return cell
    }
    
    fileprivate func createMutualFriendCell() -> UITableViewCell {
        let cell = MutualFriendContractTableViewCell(numOfFriends: totalMutualFriends)
        cell.mutualFriends = mutualFriends
        return cell
    }
    
    fileprivate func createContactAdminCell() -> UITableViewCell {
        let cell = CreationTableViewCell(iconImage: #imageLiteral(resourceName: "QuestionMark"), titleText: "Have A Problem?")
        return cell
    }
}

//cell actions
extension CustomerContractViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellType = cellData[indexPath.row]
        switch cellType {
        case .contactAdmin:
            contactUsTapped()
        default:
            break
        }
    }
}

extension CustomerContractViewController: CustomerContractDataStoreDelegate {
    func received(mutualFriends: [MutualFriend], totalCount: Int) {
        if totalCount > 0 {
            self.mutualFriends = mutualFriends
            self.totalMutualFriends = totalCount
            cellData = CustomerContractCell.insertInto(array: cellData, type: .mutualFriends)
            theTableView.reloadData()
        }
    }
}
