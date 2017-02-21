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
    var theVenmoRow: TextFieldRowFormer<FormTextFieldCell>!
    
    override var isComplete: Bool {
        let isComplete: Bool = CreationData.validateCompletion(gig: gig ?? Gig(), type: .contact)
        return isComplete
    }
    
    override var passingCellUpdatedTitle: String? {
        if let phoneNumber = thePhoneNumberRow.text, let formattedPhoneNumber: String = PhoneValidator.format(phoneNumber: phoneNumber)  {
            return formattedPhoneNumber
        }
        return super.passingCellUpdatedTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameRowSetup()
        lastNameRowSetup()
        phoneNumberRowSetup()
        venmoRowSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func save(sender: UIBarButtonItem) {
        gig?.creator.theFirstName = theFirstNameRow.text ?? ""
        gig?.creator.theLastName = theLastNameRow.text ?? ""
        if let phoneNumber = thePhoneNumberRow.text?.toDouble() {
            gig?.phoneNumber = Double(phoneNumber)
        }
        gig?.creator.venmoUsername = theVenmoRow.text
        super.save(sender: sender)
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
            if let firstName = gig?.creator.theFirstName {
                //check if they have already saved a first name for this gig
                row.text = firstName
            }else if let firstName = User.current()?.theFirstName {
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
            } else if let lastName = User.current()?.theLastName {
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
            if let phoneNumber = gig?.phoneNumberString, PhoneValidator.isValidPhoneNumber(phoneString: phoneNumber) {
                row.text = phoneNumber
            } else if let phoneNumber = User.current()?.phoneNumber {
                gig?.phoneNumber = phoneNumber
                row.text = gig?.phoneNumberString
            }
        }
        _ = append(rows: [thePhoneNumberRow], headerTitle: "Phone Number")
    }
}

//venmo extension
extension ContactFormViewController {
    fileprivate func venmoRowSetup() {
        theVenmoRow = TextFieldRowFormer<FormTextFieldCell>()
        theVenmoRow.configure { (row) in
            row.placeholder = "i.e. Johnny-Bravo"
            row.text = gig?.creator.venmoUsername
        }
        
        let header = LabelViewFormer<FormLabelHeaderView>()
        header.text = "Venmo Username"
        
        let footer = LabelViewFormer<FormLabelFooterView>()
        footer.text = "We use your venmo username to allow customers to be directed to your venmo page. We have no access to any of your venmo payments or accounts. It is merely to allow customers to quickly navigate to your venmo page and pay you."
        footer.configure { (view) in
            view.viewHeight = 100
        }
        
        let section = SectionFormer(rowFormer: theVenmoRow)
        section.set(headerViewFormer: header)
        section.set(footerViewFormer: footer)
        former.append(sectionFormer: section)
    }
}


