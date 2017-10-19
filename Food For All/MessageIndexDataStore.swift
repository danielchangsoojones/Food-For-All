//
//  MessageIndexDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 4/26/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol MessageIndexDataStoreDelegate {
    func loaded(_ chatRooms: [ChatRoom])
}

class MessageIndexDataStore {
    var delegate: MessageIndexDataStoreDelegate?
    
    init(delegate: MessageIndexDataStoreDelegate) {
        self.delegate = delegate
    }
    
    func loadMessages() {
        PFCloud.callFunction(inBackground: "loadMessages", withParameters: [:], block: {
            (results: Any?, error: Error?) -> Void in
            if let results = results as? [Any] {
                print(results)
//                self.delegate?.loaded(chat)
            } else if let error = error {
                print(error)
            }
        })
    }
}
