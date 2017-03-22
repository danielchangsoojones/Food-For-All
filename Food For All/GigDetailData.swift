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
        case .information, .estimatedDuration:
            return UITableViewAutomaticDimension
        case .photos:
            return 155
        case .mutualFriends:
            return 155
        default:
            return 70
        }
    }
    
    func createInformationCell(gig: Gig) -> InformationTableViewCell {
        return InformationTableViewCell(title: gig.title, description: gig.description)
    }
    
    func createEstimatedDurationCell(gig: Gig) -> InformationTableViewCell {
        return InformationTableViewCell(title: ServiceFormViewController.Constants.estimatedDuration, description: gig.estimatedDuration ?? "")
    }
    
    func createPhotosCell(photos: [GigPhoto], delegate: GigPhotosCellDelegate) -> GigPhotosTableViewCell {
        return GigPhotosTableViewCell(photos: photos, delegate: delegate)
    }
    
    func createReviewCell(gig: Gig) -> RatingTableViewCell {
        return RatingTableViewCell(numOfReviews: gig.numOfReviews, avgStars: gig.avgStars)
    }
    
    func createMutualFriendsCell(numOfFriends: Int) -> MutualFriendTableViewCell {
        return MutualFriendTableViewCell(numOfFriends: numOfFriends)
    }
    
    func createMessageCell() -> GigItemTableViewCell {
        let cell = GigItemTableViewCell()
        cell.set(title: "Message")
        return cell
    }
    
    func createVenmoCell() -> VenmoTableViewCell {
        return VenmoTableViewCell()
    }
}

//anytime you add a new cell type, it needs to be ordered correctly in the array and in the cases.
enum GigItemType: Int {
    case information = 0
    case estimatedDuration = 1
    case photos = 2
    case review = 3
    case mutualFriends = 4
    case message = 5
    case venmo = 6
    
    static let mandatory: [GigItemType] = [.information, .review, .message, .venmo]
    static func insertInto(array: [GigItemType], type: GigItemType) -> [GigItemType] {
        var arrayCopy = array
        let targetIndex = array.index { (item: GigItemType) -> Bool in
            return item.rawValue > type.rawValue
        }
        
        if let targetIndex = targetIndex {
            arrayCopy.insert(type, at: targetIndex)
        }
        
        return arrayCopy
    }
}
