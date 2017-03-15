//
//  ContractCellData.swift
//  Food For All
//
//  Created by Daniel Jones on 3/12/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

enum ContractCell: Int {
    case description = 0
    case message = 1
    case venmo = 2
    
    static let all: [ContractCell] = [.description, .message, .venmo]
}

class ContractCellData {
    init() {}
    
    func createDescriptionCell(contract: Contract?) -> ContractTableViewCell {
        let cell = ContractTableViewCell(style: .default, reuseIdentifier: nil)
        if let gig = contract?.gig {
            cell.theTitleLabel.text = gig.title
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"
            var dateString: String? = nil
            if let date = contract?.plannedTime {
                dateString = formatter.string(from: date)
            }
            cell.set(price: gig.priceString, time: dateString)
        }
        return cell
    }
    
    func createMessageCell() -> CreationTableViewCell {
        let cell = CreationTableViewCell(iconImage: #imageLiteral(resourceName: "messageIcon"), titleText: "Message")
        return cell
    }
    
    func createVenmoCell() -> VenmoContractTableViewCell {
        let cell = VenmoContractTableViewCell()
        return cell
    }
}

