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
    
    var pricingCell: CreationTableViewCell {
        let image = #imageLiteral(resourceName: "MoneySymbol")
        let cell = CreationTableViewCell(iconImage: image, titleText: "What price?")
        return cell
    }
    
    var contact: CellData {
        let cell = contactCell
        let destinationVC = ContactFormViewController()
        return CellData(cell: cell, destinationVC: destinationVC)
    }
    
    var contactCell: CreationTableViewCell {
        let image = #imageLiteral(resourceName: "PhoneSymbol")
        let cell = CreationTableViewCell(iconImage: image, titleText: "How to contact?")
        return cell
    }
    
    var cellDatas: [CellData] {
        return [service, pricing, contact]
    }
}

enum Creation: Int {
    //based on ordering in tableView
    case service = 0
    case pricing = 1
    case contact = 2
    
    static var count: Int = 3
}

extension CreationData {
    static func validateCompletion(gig: Gig, type: Creation) -> Bool {
        var isComplete: Bool = false
        switch type {
        case .service:
            isComplete = gig.title.isNotEmpty && gig.description.isNotEmpty
        case .pricing:
            isComplete = (gig.price >= 0) && gig.priceUnit.isNotEmpty
        case .contact:
            let phoneString = Int(gig.phoneNumber).toString //so it doesn't end in a .0 as a double (i.e. 3176905323.0)
            let firstNameExists: Bool = gig.creator.firstName?.isNotEmpty ?? false
            let lastNameExists: Bool = gig.creator.lastName?.isNotEmpty ?? false
            isComplete = PhoneValidator.isValidPhoneNumber(phoneString: phoneString) && firstNameExists && lastNameExists
        }
        
        return isComplete
    }
    
    static func extractCellTitle(gig: Gig, type: Creation) -> String? {
        var title: String?
        switch type {
        case .service:
            if gig.title.isNotEmpty {
                title = gig.title
            }
        case .pricing:
            if gig.price >= 0 {
                title = gig.priceString
            }
        case .contact:
            let phoneString = Int(gig.phoneNumber).toString
            if PhoneValidator.isValidPhoneNumber(phoneString: phoneString) {
                title = PhoneValidator.format(phoneNumber: phoneString)
            }
        }
        
        return title
    }
}
