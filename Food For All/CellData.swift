//
//  CellData.swift
//  Food For All
//
//  Created by Daniel Jones on 2/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

struct CellData {
    static var serviceInfoCell: CreationTableViewCell {
        let image = #imageLiteral(resourceName: "Pencil")
        let cell = CreationTableViewCell(iconImage: image, titleText: "What's your service?")
        return cell
    }
    
    static var pricingCell: CreationTableViewCell {
        let image = #imageLiteral(resourceName: "MoneySymbol")
        let cell = CreationTableViewCell(iconImage: image, titleText: "What Price?")
        return cell
    }
    
    static var contactCell: CreationTableViewCell {
        let image = #imageLiteral(resourceName: "PhoneSymbol")
        let cell = CreationTableViewCell(iconImage: image, titleText: "How to contact?")
        return cell
    }
    
    static let creationCells = [CellData.serviceInfoCell, CellData.pricingCell, CellData.contactCell]
}
