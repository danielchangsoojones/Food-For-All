//
//  ChatViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 10/17/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import MessageKit

class ChatViewController: MessagesViewController {
    var chatRoom: ChatRoom!
    var messages: [MessageType] = [] {
        didSet {
            messagesCollectionView.reloadData()
        }
    }
//
//    init(chatRoom: ChatRoom) {
//        super.init(nibName: nil, bundle: nil)
//        self.chatRoom = chatRoom
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageDelegateSetup()
    }
    
    private func messageDelegateSetup() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }
}

extension ChatViewController: MessagesDataSource {
    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func currentSender() -> Sender {
        return Sender(id: User.current()?.objectId ?? Helpers.randomString(length: 10), displayName: User.current()?.theFirstName ?? "Unknown")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
}

extension ChatViewController: MessageInputBarDelegate {
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let message = CustomMessageType(text: "Heyyyy", sender: currentSender())
        messages.append(message)
    }
}

extension ChatViewController: MessagesDisplayDelegate, MessagesLayoutDelegate {
    func avatarSize(for: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        //don't show avatar images. Simpler than having to code out avatar images
        return CGSize.zero
    }
}
