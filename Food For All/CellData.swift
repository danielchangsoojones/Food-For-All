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
    var destinationVC: UIViewController
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
    
    var photos: CellData {
        let cell = photosCell
        let destinationVC = PhotosFormViewController()
        return CellData(cell: cell, destinationVC: destinationVC)
    }
    
    var photosCell: CreationTableViewCell {
        let image = #imageLiteral(resourceName: "Camera").withRenderingMode(.alwaysTemplate)
        let cell = CreationTableViewCell(iconImage: image, titleText: "Photos")
        return cell
    }
}

enum Creation: Int {
    //based on ordering in tableView
    case service = 0
    case pricing = 1
    case contact = 2
    case photos = 3
    
    static var count: Int {
        // starting at zero, verify whether the enum can be instantiated from the Int and increment until it cannot
        var count = 0
        while let _ = Creation(rawValue: count) { count += 1 }
        return count
    }
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
            let phoneString = gig.phoneNumberString //so it doesn't end in a .0 as a double (i.e. 3176905323.0)
            let firstNameExists: Bool = gig.creator.theFirstName.isNotEmpty
            let lastNameExists: Bool = gig.creator.theLastName.isNotEmpty
            isComplete = PhoneValidator.isValidPhoneNumber(phoneString: phoneString) && firstNameExists && lastNameExists
        case .photos:
            isComplete = true
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
            let phoneString = gig.phoneNumberString
            if PhoneValidator.isValidPhoneNumber(phoneString: phoneString) {
                title = PhoneValidator.format(phoneNumber: phoneString)
            }
        case .photos:
            break
        }
        
        return title
    }
}
