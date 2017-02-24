//
//  AgreementViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/23/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class AgreementViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        CustomColors.addGradient(colors: CustomColors.creationGradientColors, to: self.view)
    }
    
    fileprivate func viewSetup() {
        let agreementView = AgreementView(frame: self.view.bounds)
        self.view = agreementView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
