//
//  ContactHelper.swift
//  Food For All
//
//  Created by Daniel Jones on 4/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView
import MessageUI

class ContactHelper: NSObject {
    var messageHelper: MessageHelper?
    
    func contactUs(currentVC: UIViewController) {
        let alert = SCLAlertView()
        alert.addButton("Contact Us") { 
            self.messageHelper = MessageHelper(currentVC: currentVC, phoneNumber: "3172132960")
            self.messageHelper?.show()
        }
        alert.showNotice("Contact Our Founder", subTitle: "We're going to get you in touch with one of Gigio's Founders: Mike McHugh. Mike loves being helpful.", closeButtonTitle: "Cancel")
    }
}
