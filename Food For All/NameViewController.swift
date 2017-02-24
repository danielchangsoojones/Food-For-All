//
//  NameViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/20/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class NameViewController: WelcomeFormViewController {
    var dataStore: NameDataStore = NameDataStore()
    
    override var welcomeFormView: WelcomeFormView {
        return WelcomeFormView(frame: self.view.bounds, title: "Name", topTextFieldTitle: "First Name", bottomTextFieldTitle: "Last Name")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var isComplete: Bool {
        guard let firstName = theTopTextField?.text else {
            return false
        }
        guard let lastName = theBottomTextField?.text else {
            return false
        }
        
        if firstName.isEmpty {
            Helpers.showBanner(title: "First Name Missing", subtitle: "please input your first name", bannerType: .error)
            return false
        }
        if lastName.isEmpty {
            Helpers.showBanner(title: "Last Name Missing", subtitle: "please input your last name", bannerType: .error)
            return false
        }
        
        return true
    }
    
    override func forwardButtonPressed(sender: UIButton?) {
        super.forwardButtonPressed(sender: sender)
        if isComplete {
            dataStore.save(firstName: theTopTextField?.text ?? "", lastName: theBottomTextField?.text ?? "")
            presentVC(AgreementViewController())
        }
    }
}
