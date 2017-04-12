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
    struct Constants {
        static let estimatedDuration = "Estimated Duration"
    }
    
    var titleRow = TextFieldRowFormer<FormTextFieldCell>()
    var descriptionRow = TextViewRowFormer<FormTextViewCell>()
    var durationRow = TextViewRowFormer<FormTextViewCell>()
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
        durationFormSetup()
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
        if let duration = durationRow.cell.textView.text {
            gig?.estimatedDuration = duration
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
        
        titleRow.cell.textField.tag = Forms.service.rawValue
        titleRow.cell.textField.delegate = self
        
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
    
    fileprivate func durationFormSetup() {
        durationRow.configure { row in
            row.placeholder = "How long will the service take?"
            if let description = gig?.estimatedDuration {
                row.text = description
            }
        }
        
        let header = LabelViewFormer<FormLabelHeaderView>()
        header.text = Constants.estimatedDuration
        
        let footer = LabelViewFormer<FormLabelFooterView>()
        footer.text = "The maximum time necessary for you to complete the task. This field is optional"
        footer.configure { (view) in
            //TODO: make the height based upon the size of the letters, so we can change it without concern. I'm just gauging by eye right now
            view.viewHeight = 50
        }
        
        let section = SectionFormer(rowFormer: durationRow)
        section.set(headerViewFormer: header)
        section.set(footerViewFormer: footer)
        former.append(sectionFormer: section)
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
        
        tagRow.onValueChanged { (row) in
            print(row)
        }
        
        former.onCellSelected { (indexPath: IndexPath) in
            if let selectedRow = self.former.rowFormer(indexPath: indexPath) as? InlinePickerRowFormer<FormInlinePickerCell, String>, selectedRow.cell == self.tagRow.cell {
                //the category row
                Timer.runThisAfterDelay(seconds: 0.4, after: {
                    //the height of the cell does not include the height of the inline picker, so we need to add a custom height for the targetScrollFrame, plus we need to wait until the tableview has actually grown to the size of the inline picker, or else it will think the rect is already visible.
                    let targetFrame = CGRect(x: selectedRow.cell.frame.x, y: selectedRow.cell.frame.y, w: selectedRow.cell.frame.width, h: 500)
                    self.tableView.scrollRectToVisible(targetFrame, animated: true)
                })
            }
        }
        
        _ = append(rows: [tagRow], headerTitle: "Category")
    }
}

extension ServiceFormViewController: UITextFieldDelegate {
    enum Forms: Int {
        case service
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let form = Forms(rawValue: textField.tag) {
            switch form {
            case .service:
                guard let text = textField.text else { return true }
                let newLength = text.characters.count + string.characters.count - range.length
                //TODO: 50 is an arbitrary number, just want to make sure that users don't input a title that flow off the screen
                let limitLength = 35
                return newLength <= limitLength
            }
        }
        
        return true
    }
}
