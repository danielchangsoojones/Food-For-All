//
//  ChatDataStore.swift
//  Food For All
//
//  Created by Daniel Jones on 10/19/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import Parse

protocol ChatDataDelegate {
    func loaded(_ messages: [Message])
}

class ChatDataStore {
    var delegate: ChatDataDelegate?
    
    init(delegate: ChatDataDelegate) {
        self.delegate = delegate
    }
}

extension ChatDataStore {
    func loadMessages(for chatRoom: ChatRoom) {
        if let chatRoomParseObjectID = chatRoom.chatRoomParse?.objectId {
            PFCloud.callFunction(inBackground: "loadMessages", withParameters: ["chatRoomObjectID" : chatRoomParseObjectID], block: {
                (results: Any?, error: Error?) -> Void in
                if let messageParses = results as? [MessageParse] {
                    let messages = self.map(messageParses)
                    self.delegate?.loaded(messages)
                } else if let error = error {
                    Helpers.showBanner(title: "Message Error", subtitle: error.localizedDescription, bannerType: .error)
                }
            })
        }
    }
    
    private func map(_ messageParses: [MessageParse]) -> [Message] {
        let messages = messageParses.map({ (m: MessageParse) -> Message in
            let message = Message(messageParse: m)
            return message
        })
        return messages
    }
}

extension ChatDataStore {
    func send(_ message: Message, from chatRoom: ChatRoom) {
        if let currentUser = User.current(), let chatRoomParse = chatRoom.chatRoomParse {
            message.messageParse?.chatRoom = chatRoomParse
            message.messageParse?.sender = currentUser
            message.messageParse?.saveInBackground(block: { (success, error) in
                if let error = error {
                    Helpers.showBanner(title: "Sending Error", subtitle: error.localizedDescription)
                }
            })
        }
    }
}
