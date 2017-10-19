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
    

}

extension MessageIndexDataStore {
    func loadMessages() {
        PFCloud.callFunction(inBackground: "loadChatRooms", withParameters: [:], block: {
            (results: Any?, error: Error?) -> Void in
            if let results = results as? [Any] {
                let chatRooms = self.parse(results)
                self.delegate?.loaded(chatRooms)
            } else if let error = error {
                print(error)
            }
        })
    }
    
    private func parse(_ results: [Any]) -> [ChatRoom] {
        var chatRooms: [ChatRoom] = []
        for case let result as [Any] in results {
            if let chatRoomParse = result.first as? ChatRoomParse, let messages = result[1] as? [MessageParse], let firstMessage = messages.first {
                let chatRoom = ChatRoom(chatRoomParse: chatRoomParse)
                chatRoom.lastMessage = Message(messageParse: firstMessage)
                chatRooms.append(chatRoom)
            }
        }
        
        return chatRooms
    }
}
