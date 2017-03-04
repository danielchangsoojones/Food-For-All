//
//  Message.swift
//  Food For All
//
//  Created by Daniel Jones on 3/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import MessageUI

class Message: NSObject {
    enum MessageType {
        case blank
        case withoutTime
        case withTime
    }
    
    var theSpinnerContainer: UIView?
    var gig: Gig!
    var currentVC: UIViewController!
    var time: String?
    var type: MessageType = .blank
    
    init(currentVC: UIViewController, gig: Gig) {
        super.init()
        self.currentVC = currentVC
        self.gig = gig
    }
    
    func send(type: MessageType, time: String? = nil) {
        self.time = time
        self.type = type
        theSpinnerContainer = Helpers.showActivityIndicatory(uiView: currentVC.view)
        Timer.runThisAfterDelay(seconds: 0.01) {
            //the spinner was taking a while to show up because sendSMS was somehow taking up the processing, so it felt like the user had not pressed the button. This fixed it.
            self.sendSMSText(phoneNumber: self.gig.phoneNumberString)
        }
    }
    
    func sendSMSText(phoneNumber: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            
            var firstName: String = gig.creator.theFirstName
            if firstName.isNotEmpty {
                firstName = " " + firstName
            }
            controller.body = getMessageBody(gig: gig)
            controller.recipients = [phoneNumber]
            controller.messageComposeDelegate = self
            currentVC.present(controller, animated: true, completion: {
                self.theSpinnerContainer?.removeFromSuperview()
            })
        } else {
            theSpinnerContainer?.removeFromSuperview()
            Helpers.showBanner(title: "Message Error", subtitle: "Can not send messages currently")
        }
    }
    
    fileprivate func getMessageBody(gig: Gig) -> String {
        var firstName: String = gig.creator.theFirstName
        if firstName.isNotEmpty {
            firstName = " " + firstName
        }
        var body = "Hey\(firstName), I found you on Gigio for \(gig.title)."
        
        switch type {
        case .withoutTime:
            body += " Can we arrange something?"
        case .withTime:
            if let time = time {
                body += " Can we plan something at \(time)?"
            }
        case .blank:
            body = ""
        }
        return body
    }
}

extension Message: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        var messageState: String = "defualt"
        
        switch result {
        case .cancelled:
            messageState = "clicked, but then cancelled"
        case .failed:
            messageState = "failure to send"
        case .sent:
            messageState = "successfully sent"
        }
        
       MessageDataStore().saveMessageMetric(messageState: messageState, gig: gig)
        
        currentVC.dismiss(animated: true, completion: {
            Helpers.showBanner(title: "Succesful Message", subtitle: "You have succesfully texted the tutor", bannerType: .success)
        })
    }
}
