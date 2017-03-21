//
//  MessageDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 3/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse
import Mixpanel
import Alamofire

class MessageDataStore {
    func saveMessageMetric(messageState: String, gig: Gig) {
        let metric = MessageMetrics()
        if let currentUser = User.current() {
            metric.customer = currentUser
        }
        metric.gig = gig.gigParse
        metric.state = messageState
        metric.saveInBackground()
        saveMixPanelMesageMetric(state: messageState, gig: gig)
        sendGroupMeMessage(state: messageState)
    }
    
    fileprivate func saveMixPanelMesageMetric(state: String, gig: Gig) {
        Mixpanel.mainInstance().track(event: "Message", properties: ["status" : state, "recipient" : gig.creator.fullName ?? "Unknown"])
    }
    
    fileprivate func sendGroupMeMessage(state: String) {
        var configuration = Configuration()
        if configuration.environment == .Production {
            let url = "https://maker.ifttt.com/trigger/new-user-message/with/key/bmku_IppapnZ3eewT54mzi"
            let fullName = User.current()?.fullName ?? ""
            let parameters: Parameters = ["value1" : fullName, "value2" : state]
            Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData(completionHandler: { (response) in
                print(response)
            })
        }
    }
}
