//
//  DetailDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 1/27/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import ParseFacebookUtilsV4
import SwiftyJSON

protocol DetailDataStoreDelegate {
    func received(mutualFriends: [MutualFriend], totalCount: Int)
}

class DetailDataStore {
    var delegate: DetailDataStoreDelegate?
    
    func saveMessageMetric(messageState: String, gig: Gig) {
        let metric = MessageMetrics()
        if let currentUser = User.current() {
            metric.customer = currentUser
        }
        metric.gig = gig.gigParse
        metric.state = messageState
        metric.saveInBackground()
    }
    
    func saveVenmoMetric(state: String, gig: Gig) {
        let metric = VenmoMetric()
        if let currentUser = User.current() {
            metric.customer = currentUser
        }
        metric.gig = gig.gigParse
        metric.state = state
        metric.saveInBackground()
    }
}

extension DetailDataStore {
    func getMutualFriends(creator: Person) {
        if let creatorFBID = creator.updatedUser.facebookId {
            PFCloud.callFunction(inBackground: "findMutualFriends", withParameters: ["targetUserFacebookID": creatorFBID], block: {
                (result: Any?, error: Error?) -> Void in
                if let result = result {
                    let json = JSON(result)
                    let context = json["context"]["all_mutual_friends"]
                    let totalCount: Int = context["summary"]["total_count"].int ?? 0
                    
                    let mutualFriends: [MutualFriend] = context["data"].arrayValue.map({
                        let firstName = $0["first_name"].stringValue
                        let pictureData = $0["picture"]["data"]
                        let url: String = pictureData["url"].stringValue
                        
                        let mutualFriend = MutualFriend(firstName: firstName, profileImage: url)
                        return mutualFriend
                    })
                    
                    self.delegate?.received(mutualFriends: mutualFriends, totalCount: totalCount)
                } else if let error = error {
                    print(error)
                }
            })
        }
    }
}


