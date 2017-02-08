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
        gig?.creator.firstName = theFirstNameRow.text
        gig?.creator.lastName = theLastNameRow.text
        if let phoneNumber = thePhoneNumberRow.text?.toInt() {
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
            if let phoneNumber = gig?.phoneNumber, PhoneValidator.isValidPhoneNumber(phoneString: phoneNumber.toString) {
                row.text = phoneNumber.toString
            }
            //TODO: have the person's phone number saved to their account, so then it will come up automatically, but then you should be able to change the phone number for every gig too.
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
//            if let venmoUsername = gig?.creator.venmoUsername {
//                row.text = venmoUsername
//            }
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
    
//    fileprivate func venmoFooterSetup() -> ViewFormer {
//        let footer = LabelViewFormer<FormLabelFooterView>()
//        footer.text = "We use your venmo username to allow customers to be directed to your venmo page. We have no access to any of your venmo payments or accounts. It is merely to allow customers to quickly navigate to your venmo page and pay you."
//        return footer
//    }
}


