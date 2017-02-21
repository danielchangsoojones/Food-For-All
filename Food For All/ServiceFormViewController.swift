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
    var tagRow: InlinePickerRowFormer<FormInlinePickerCell, String>!
    
    override var isComplete: Bool {
        let isComplete: Bool = CreationData.validateCompletion(gig: gig ?? Gig(), type: .service)
        return isComplete
    }
    
    override var passingCellUpdatedTitle: String? {
        return titleRow.cell.textField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleFormSetup()
        descriptionFormSetup()
        tagFormSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func save(sender: UIBarButtonItem) {
        if let title = titleRow.cell.textField.text {
            gig?.title = title
        }
        if let description = descriptionRow.cell.textView.text {
            gig?.description = description
        }
        gig?.tags = [categories[tagRow.selectedRow]]
        super.save(sender: sender)
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
            if let description = gig?.description {
                row.text = description
            }
        }
        _ = append(rows: [descriptionRow], headerTitle: "Description")
    }
    
    var categories: [String] {
        return Helpers.categories
    }
    
    fileprivate func tagFormSetup() {
        tagRow = InlinePickerRowFormer<FormInlinePickerCell, String>(cellSetup: {
            $0.titleLabel.text = "Category"
        })
        tagRow.configure { (row) in
            if let tags = gig?.tags {
                let categoryIndex: Int = categories.index(where: { (str: String) -> Bool in
                    return str.lowercased() == tags.first?.lowercased()
                }) ?? 0
                row.selectedRow = categoryIndex
            }
            row.pickerItems = categories.map {
                InlinePickerItem(title: $0)
            }
        }
        
        _ = append(rows: [tagRow], headerTitle: "Category")
    }
}
