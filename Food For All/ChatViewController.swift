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
    var messages: [Message] = []
    var dataStore: ChatDataStore?

    init(chatRoom: ChatRoom) {
        super.init(nibName: nil, bundle: nil)
        self.chatRoom = chatRoom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageDelegateSetup()
        chatHeadingSetup()
        dataStoreSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dataStore?.disconnectFromChatRoom()
    }
    
    private func messageDelegateSetup() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
    }
    
    private func chatHeadingSetup() {
        self.title = chatRoom.otherUser.theFirstName
    }
    
    private func dataStoreSetup() {
        dataStore = ChatDataStore(delegate: self)
        dataStore?.loadMessages(for: chatRoom)
        dataStore?.subscribeToUpdates(for: chatRoom)
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
        return messages[indexPath.section].messageType
    }
}

extension ChatViewController: MessageInputBarDelegate {
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let message = Message(text: text)
        message.messageType = CustomMessageType(text: text, sender: currentSender())
        messages.append(message)
        messagesCollectionView.reloadData()
        inputBar.inputTextView.text = ""
        dataStore?.send(message, from: chatRoom)
    }
}

extension ChatViewController: MessagesDisplayDelegate, MessagesLayoutDelegate {
    func avatarSize(for: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        //don't show avatar images. Simpler than having to code out avatar images
        return CGSize.zero
    }
}

extension ChatViewController: ChatDataDelegate {
    func loaded(_ messages: [Message]) {
        setSenders(to: messages)
        //need to reverse the messages because we receive them in the newest order, but the collection view needs to place the newest messages at the bottom, hence reversed.
        let newestOrderedMessages: [Message] = messages.reversed()
        self.messages = newestOrderedMessages
        messagesCollectionView.reloadData()
    }
    
    func received(_ newMessage: Message) {
        let sender = createSender(for: chatRoom.otherUser)
        set(sender, to: newMessage)
        messages.append(newMessage)
        messagesCollectionView.reloadData()
    }
    
    private func setSenders(to messages: [Message]) {
        for message in messages {
            if message.sender.objectId == User.current()?.objectId {
                set(currentSender(), to: message)
            } else {
                let messageSender = message.sender
                let sender = createSender(for: messageSender)
                set(sender, to: message)
            }
        }
    }
    
    private func createSender(for otherUser: User) -> Sender {
        let sender = Sender(id: otherUser.objectId ?? "Unknown", displayName: otherUser.theFirstName)
        return sender
    }
    
    private func set(_ sender: Sender, to message: Message) {
        message.messageType = CustomMessageType(text: message.text, sender: sender)
    }
}
