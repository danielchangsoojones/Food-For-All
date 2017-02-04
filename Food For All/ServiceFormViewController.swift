//
//  ServiceFormViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Former

class ServiceFormViewController: SuperCreationFormViewController {
    var titleRow = TextFieldRowFormer<FormTextFieldCell>()
    var descriptionRow = TextViewRowFormer<FormTextViewCell>()
    
    override var isComplete: Bool {
        let isTitleComplete: Bool = titleRow.cell.textField.text?.isNotEmpty ?? false
        let isDescriptionComplete: Bool = descriptionRow.cell.textView.text.isNotEmpty
        let isComplete: Bool = isTitleComplete && isDescriptionComplete
        return isComplete
    }
    
    override var passingCellUpdatedTitle: String? {
        return titleRow.cell.textField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleFormSetup()
        descriptionFormSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func save(sender: UIBarButtonItem) {
        super.save(sender: sender)
        if let title = titleRow.cell.textField.text {
            gig?.title = title
        }
        if let description = descriptionRow.cell.textView.text {
            gig?.description = description
        }
    }
}

extension ServiceFormViewController {
    fileprivate func titleFormSetup() {
        titleRow.configure { row in
            row.placeholder = "Name of your service?"
            if let title = gig?.title {
                row.text = title
            }
        }
        
        _ = append(rows: [titleRow], headerTitle: "Title")
    }
    
    fileprivate func descriptionFormSetup() {
        descriptionRow.configure { row in
            row.placeholder = "Describe your service/qualifications..."
        }
        _ = append(rows: [descriptionRow], headerTitle: "Description")
    }
}
