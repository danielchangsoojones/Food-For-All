//
//  ContactFormViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Former

class ContactFormViewController: SuperCreationFormViewController {
    var theFirstNameRow: TextFieldRowFormer<FormTextFieldCell>!
    var theLastNameRow: TextFieldRowFormer<FormTextFieldCell>!
    var thePhoneNumberRow: TextFieldRowFormer<FormTextFieldCell>!
    
    override var isComplete: Bool {
        let isFirstNameComplete: Bool = isRowFilled(row: theFirstNameRow)
        let isLastNameComplete: Bool = isRowFilled(row: theLastNameRow)
        let isPhoneNumberComplete: Bool = isRowFilled(row: thePhoneNumberRow) && isValidPhoneNumber(phoneString: thePhoneNumberRow.text)
        return isFirstNameComplete && isLastNameComplete && isPhoneNumberComplete
    }
    
    override var passingCellUpdatedTitle: String? {
        if let phoneNumber = thePhoneNumberRow.text, let formattedPhoneNumber: String = format(phoneNumber: phoneNumber)  {
            return formattedPhoneNumber
        }
        return super.passingCellUpdatedTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameRowSetup()
        lastNameRowSetup()
        phoneNumberRowSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func save(sender: UIBarButtonItem) {
        super.save(sender: sender)
        gig?.creator.firstName = theFirstNameRow.text
        gig?.creator.lastName = theLastNameRow.text
        if let phoneNumber = thePhoneNumberRow.text?.toInt() {
            gig?.phoneNumber = phoneNumber
        }
    }
    
    fileprivate func isRowFilled(row: TextFieldRowFormer<FormTextFieldCell>) -> Bool {
        return row.text?.isNotEmpty ?? false
    }
}

extension ContactFormViewController {
    fileprivate func firstNameRowSetup() {
        theFirstNameRow = TextFieldRowFormer<FormTextFieldCell>()
        theFirstNameRow.configure { (row) in
            row.placeholder = "first name..."
            if let firstName = gig?.creator.firstName {
                //check if they have already saved a first name for this gig
                row.text = firstName
            }else if let firstName = Person.current().firstName {
                //if not, then check if they even already have one
                row.text = firstName
            }
        }
        _ = append(rows: [theFirstNameRow], headerTitle: "First Name")
    }
    
    fileprivate func lastNameRowSetup() {
        theLastNameRow = TextFieldRowFormer<FormTextFieldCell>()
        theLastNameRow.configure { (row) in
            row.placeholder = "last name..."
            if let lastName = gig?.creator.lastName {
                //check if they have already saved a first name for this gig
                row.text = lastName
            } else if let lastName = Person.current().lastName {
                row.text = lastName
            }
        }
        _ = append(rows: [theLastNameRow], headerTitle: "Last Name")
    }
}

extension ContactFormViewController {
    //TODO: format the text field to work for phone numbers style (xxx)-xxx-xxxx
    fileprivate func phoneNumberRowSetup() {
        thePhoneNumberRow = TextFieldRowFormer<FormTextFieldCell>()
        thePhoneNumberRow.configure { (row) in
            row.placeholder = "i.e. 3179184040"
            if let phoneNumber = gig?.phoneNumber, isValidPhoneNumber(phoneString: phoneNumber.toString) {
                row.text = phoneNumber.toString
            }
            //TODO: have the person's phone number saved to their account, so then it will come up automatically, but then you should be able to change the phone number for every gig too.
        }
        _ = append(rows: [thePhoneNumberRow], headerTitle: "Phone Number")
    }
    
    func format(phoneNumber sourcePhoneNumber: String) -> String? {
        
        // Remove any character that is not a number
        let numbersOnly = sourcePhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let length = numbersOnly.characters.count
        let hasLeadingOne = numbersOnly.hasPrefix("1")
        
        // Check for supported phone number length
        guard length == 7 || length == 10 || (length == 11 && hasLeadingOne) else {
            return nil
        }
        
        let hasAreaCode = (length >= 10)
        var sourceIndex = 0
        
        // Leading 1
        var leadingOne = ""
        if hasLeadingOne {
            leadingOne = "1 "
            sourceIndex += 1
        }
        
        // Area code
        var areaCode = ""
        if hasAreaCode {
            let areaCodeLength = 3
            guard let areaCodeSubstring = numbersOnly.characters.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
                return nil
            }
            areaCode = String(format: "(%@) ", areaCodeSubstring)
            sourceIndex += areaCodeLength
        }
        
        // Prefix, 3 characters
        let prefixLength = 3
        guard let prefix = numbersOnly.characters.substring(start: sourceIndex, offsetBy: prefixLength) else {
            return nil
        }
        sourceIndex += prefixLength
        
        // Suffix, 4 characters
        let suffixLength = 4
        guard let suffix = numbersOnly.characters.substring(start: sourceIndex, offsetBy: suffixLength) else {
            return nil
        }
        
        return leadingOne + areaCode + prefix + "-" + suffix
    }
    
    fileprivate func isValidPhoneNumber(phoneString: String?) -> Bool {
        if let phoneString = phoneString {
            if let _ = phoneString.toInt(), (phoneString.characters.count == 10 || phoneString.characters.count == 11) {
                return true
            }
        }
        
        return false
    }
}

extension String.CharacterView {
    /// This method makes it easier extract a substring by character index where a character is viewed as a human-readable character (grapheme cluster).
    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
        
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[substringStartIndex ..< substringEndIndex])
    }
}


