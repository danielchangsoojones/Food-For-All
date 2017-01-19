//
//  WelcomeViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/10/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    fileprivate var theFacebookButton: UIButton!
    fileprivate var theSignUpButton: UIButton!
    fileprivate var theLogInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    fileprivate func viewSetup() {
        let welcomeView = WelcomeView(frame: self.view.bounds)
        self.view = welcomeView
        theFacebookButton = welcomeView.theFacebookButton
        theSignUpButton = welcomeView.theSignUpButton
        theLogInButton = welcomeView.theLogInButton
        addTarget(to: theFacebookButton, action: #selector(facebookPressed(sender:)))
        addTarget(to: theSignUpButton, action: #selector(signUp(sender:)))
        addTarget(to: theLogInButton, action: #selector(logIn(sender:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//button actions
extension WelcomeViewController {
    func facebookPressed(sender: UIButton) {
        
    }
    
    func signUp(sender: UIButton) {
        pushVC(SignUpViewController())
    }
    
    func logIn(sender: UIButton) {
        let destinationVC = LoginViewController()
        pushVC(destinationVC)
    }
    
    fileprivate func addTarget(to button: UIButton, action: Selector) {
        button.addTarget(self, action: action, for: .touchUpInside)
    }
}
