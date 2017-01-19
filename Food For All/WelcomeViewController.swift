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
    
    var dataStore: WelcomeDataStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStore = WelcomeDataStore(delegate: self)
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
        showActivityIndicatory(uiView: self.view)
        dataStore.accessFaceBook()
    }
    
    func showActivityIndicatory(uiView: UIView) {
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0.0, y: 0.0, w: 80.0, h: 80.0)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(r: 0.25, g: 0.25, b: 0.25, a: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, w: 40.0, h: 40.0)
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
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

extension WelcomeViewController: WelcomeDataStoreDelegate {
    func segueIntoApplication() {
        print("segue into the application")
    }
}
