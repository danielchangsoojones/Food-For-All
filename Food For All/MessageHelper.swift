//
//  Message.swift
//  Food For All
//
//  Created by Daniel Jones on 3/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import MessageUI

class MessageHelper: NSObject {
    var theSpinnerContainer: UIView?
    var phoneNumber: String = "0"
    var gig: Gig?
    var currentVC: UIViewController!
    var messageDelegate: MFMessageComposeViewControllerDelegate?
    
    private init(currentVC: UIViewController, delegate: MFMessageComposeViewControllerDelegate? = nil) {
        super.init()
        self.messageDelegate = delegate
        self.currentVC = currentVC
    }
    
    convenience init(currentVC: UIViewController, gig: Gig, delegate: MFMessageComposeViewControllerDelegate? = nil) {
        self.init(currentVC: currentVC, delegate: delegate)
        self.phoneNumber = gig.phoneNumberString
        self.gig = gig
    }
    
    convenience init(currentVC: UIViewController, phoneNumber: String, delegate: MFMessageComposeViewControllerDelegate? = nil) {
        self.init(currentVC: currentVC, delegate: delegate)
        self.phoneNumber = phoneNumber
    }
    
    func show() {
        theSpinnerContainer = Helpers.showActivityIndicatory(uiView: currentVC.view)
        Timer.runThisAfterDelay(seconds: 0.01) {
            //the spinner was taking a while to show up because sendSMS was somehow taking up the processing, so it felt like the user had not pressed the button. This fixed it.
            self.sendSMSText(phoneNumber: self.phoneNumber)
        }
    }
    
    fileprivate func sendSMSText(phoneNumber: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.recipients = [phoneNumber]
            controller.messageComposeDelegate = self
            
            if let messageDelegate = messageDelegate {
                controller.messageComposeDelegate = messageDelegate
            } else {
                controller.messageComposeDelegate = self
            }
            
            currentVC.present(controller, animated: true, completion: {
                self.theSpinnerContainer?.removeFromSuperview()
            })
        } else {
            theSpinnerContainer?.removeFromSuperview()
            Helpers.showBanner(title: "Message Error", subtitle: "Can not send messages currently")
        }
    }
}

extension MessageHelper: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        saveMessageMetric(result: result)
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    func saveMessageMetric(result: MessageComposeResult) {
        if let gig = gig {
            var messageState: String = "defualt"
            
            switch result {
            case .cancelled:
                messageState = "clicked, but then cancelled"
            case .failed:
                messageState = "failure to send"
            case .sent:
                messageState = "successfully sent"
            }
            
            let dataStore = MessageDataStore()
            dataStore.saveMessageMetric(messageState: messageState, gig: gig)
        }
    }
}
