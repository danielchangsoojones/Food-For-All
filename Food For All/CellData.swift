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
    var cell: CreationTableViewCell
    var destinationVC: SuperCreationFormViewController
}

class CreationData {
    init() {}
    
    var service: CellData {
        let cell = serviceCell
        let destinationVC = ServiceFormViewController()
        return CellData(cell: cell, destinationVC: destinationVC)
    }
    
    var serviceCell: CreationTableViewCell {
        let image = #imageLiteral(resourceName: "Pencil")
        let cell = CreationTableViewCell(iconImage: image, titleText: "What's your service?")
        return cell
    }

    var pricing: CellData {
        let cell = pricingCell
        let destinationVC = PricingFormViewController()
        return CellData(cell: cell, destinationVC: destinationVC)
    }
    
    private var pricingCell: CreationTableViewCell {
        let image = #imageLiteral(resourceName: "MoneySymbol")
        let cell = CreationTableViewCell(iconImage: image, titleText: "What price?")
        return cell
    }
    
    var contact: CellData {
        let cell = contactCell
        let destinationVC = ContactFormViewController()
        return CellData(cell: cell, destinationVC: destinationVC)
    }
    
    private var contactCell: CreationTableViewCell {
        let image = #imageLiteral(resourceName: "PhoneSymbol")
        let cell = CreationTableViewCell(iconImage: image, titleText: "How to contact?")
        return cell
    }
    
    var cellDatas: [CellData] {
        return [service, pricing, contact]
    }
}
