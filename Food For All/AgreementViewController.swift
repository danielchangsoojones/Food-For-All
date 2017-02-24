//
//  AgreementViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/23/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class AgreementViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        CustomColors.addGradient(colors: CustomColors.creationGradientColors, to: self.view)
    }
    
    fileprivate func viewSetup() {
        let agreementView = AgreementView(frame: self.view.bounds)
        self.view = agreementView
        agreementView.theAgreementLabel.delegate = self
        agreementView.theAgreeButton.addTarget(self, action: #selector(agreePressed), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func agreePressed() {
        Helpers.enterApplication(from: self)
    }
}

extension AgreementViewController: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        UIApplication.shared.openURL(url)
    }
}
