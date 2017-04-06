//
//  SetLocationViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 4/5/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class SetLocationViewController: UIViewController {
    var theKeyboardAccessoryView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        title = "Set Location"
        //To show the input accessory view initially
        self.becomeFirstResponder()
        CustomColors.addGradient(colors: CustomColors.creationGradientColors, to: self.view)
    }
    
    fileprivate func viewSetup() {
        let locationView = SetLocationView(frame: self.view.bounds)
        self.view = locationView
        theKeyboardAccessoryView = locationView.theKeyboardAccessoryView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //To show the input accessory view initially
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputAccessoryView: UIView? {
        return theKeyboardAccessoryView
    }
}
