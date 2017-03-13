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

