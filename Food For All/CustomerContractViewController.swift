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
    }
}

extension CustomerContractViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CustomerContractCell.all.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let contract = CustomerContractCell(rawValue: indexPath.row) ?? .contactAdmin
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

extension CustomerContractViewController {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = CustomerContractCell(rawValue: indexPath.row) ?? .description
        var cell: UITableViewCell!
        switch cellType {
        case .description:
            cell = createDescriptionCell()
            //TODO: implement these cells
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
        let cell = MutualFriendContractTableViewCell(numOfFriends: 10)
        //TODO: set the actual mutual friends
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
        let contract = CustomerContractCell(rawValue: indexPath.row) ?? .description
        switch contract {
        case .contactAdmin:
            contactUsTapped()
        default:
            break
        }
    }
}
