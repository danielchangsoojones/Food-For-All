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

class DetailDataStore {
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
        PFCloud.callFunction(inBackground: "findMutualFriends", withParameters: [:], block: {
            (result: Any?, error: Error?) -> Void in
            if let result = result {
                let json = JSON(result)
                let context = json["context"]["all_mutual_friends"]
                let mutualFriendFirstNames: [String] = context["data"].arrayValue.map({
                    let fullName = $0["name"].stringValue
                    let firstName = self.extractFirstName(fullName: fullName)
                    return firstName
                })
                print(mutualFriendsFirstNames)
            } else if let error = error {
                print(error)
            }
        })
    }
    
    fileprivate func extractFirstName(fullName: String) -> String {
        let token = fullName.components(separatedBy: " ")
        let firstName = token[0]
        return firstName
    }
}


