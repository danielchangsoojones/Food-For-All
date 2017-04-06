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
    var theZipCodeTextField: UITextField!
    
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
        locationView.theSaveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        theZipCodeTextField = locationView.theZipCodeTextField
        theZipCodeTextField.delegate = self
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

//save extension
extension SetLocationViewController {
    func savePressed() {
        if isValidZipCode() {
            print("save the user's chosen location!")
        }
    }
    
    func isValidZipCode() -> Bool {
        if theZipCodeTextField.text?.characters.count == 5 {
            //valid zip code
            return true
        } else {
            Helpers.showBanner(title: "Invalid Zip Code", subtitle: "Please enter a valid 5 digit zip code", bannerType: .error)
            return false
        }
    }
}

extension SetLocationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        let limitLength = 5
        return newLength <= limitLength // Bool
    }
}
