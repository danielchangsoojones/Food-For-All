//
//  SettingsLocationViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 4/7/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

protocol SettingsLocationVCDelegate {
    func update(zipCode: String)
}

class SettingsLocationViewController: SetLocationViewController {
    var delegate: SettingsLocationVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func finishedSaving() {
        popVC()
        if let zipCode = theZipCodeTextField.text {
            delegate?.update(zipCode: zipCode)
        }
    }
}
