//
//  GigCellData.swift
//  Food For All
//
//  Created by Daniel Jones on 2/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

class GigDetailData {
    private var type: GigItemType = .information
    
    init(type: GigItemType) {
        self.type = type
    }
    
    var cellHeight: CGFloat {
        switch type {
        case .information:
            return UITableViewAutomaticDimension
        default:
            return 70
        }
    }
    
    func createInformationCell(gig: Gig) -> InformationTableViewCell {
        return InformationTableViewCell(title: gig.title, description: gig.description)
    }
    
    func createReviewCell(gig: Gig) -> RatingTableViewCell {
        return RatingTableViewCell(numOfReviews: gig.numOfReviews, avgStars: gig.avgStars)
    }
    
    func createVenmoCell() -> VenmoTableViewCell {
        return VenmoTableViewCell()
    }
}

//anytime you add a new cell type, it needs to be ordered correctly in the array and in the cases.
enum GigItemType: Int {
    case information = 0
    case review = 1
    case venmo = 2
    
    static let all: [GigItemType] = [.information, .review, .venmo]
}
