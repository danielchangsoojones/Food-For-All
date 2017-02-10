//
//  PricingFormViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Former

class PricingFormViewController: SuperCreationFormViewController {
    struct Constants {
        static let customUnitChoice: String = "create custom"
    }
    
    var priceRow: SliderRowFormer<FormSliderCell>!
    var unitsRow: InlinePickerRowFormer<FormInlinePickerCell, String>!
    var customUnitRow: TextFieldRowFormer<FormTextFieldCell>!
    
    var isShowingCustomUnitRow: Bool = false
    
    override var isComplete: Bool {
        let isComplete: Bool = CreationData.validateCompletion(gig: gig ?? Gig(), type: .pricing)
        return isComplete
    }
    
    override var passingCellUpdatedTitle: String? {
        let price: String = Int(priceRow.value).toString + "$"
        let unit: String = selectedUnit ?? ""
        return price + " " + unit
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        priceRowSetup()
        unitsRowSetup()
        customUnitSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let savedPrice = gig?.price {
            priceRow.cell.slider.setValue(Float(savedPrice), animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func save(sender: UIBarButtonItem) {
        gig?.price = Double(Int(priceRow.value)) //round to a int number
        let selectedUnit: String = units[unitsRow.selectedRow]
        if units.last == units[unitsRow.selectedRow] {
            //they chose custom unit
            if let customUnit = customUnitRow.cell.textField.text {
                gig?.priceUnit = customUnit
            }
        } else {
            gig?.priceUnit = selectedUnit
        }
        super.save(sender: sender)
    }
}

extension PricingFormViewController {
    fileprivate func priceRowSetup() {
        priceRow = SliderRowFormer<FormSliderCell>()
        priceRow.configure { (row) in
            row.cell.slider.maximumValue = 100
            row.cell.slider.minimumValue = 0
            if let savedPrice = gig?.price {
                row.cell.displayLabel.text = Int(savedPrice).toString + " $"
            }
            
            row.onValueChanged({ (value: Float) in
                let roundedValue = Int(value)
                row.cell.displayLabel.text = roundedValue.toString + " $"
            })
        }
        _ = append(rows:[priceRow], headerTitle: "Pricing")
    }
}

//units
extension PricingFormViewController {
    var units: [String] {
        return ["per hour", "per session", "per job", Constants.customUnitChoice]
    }
    
    var selectedUnit: String? {
        let chosenUnit: String = units[unitsRow.selectedRow]
        if chosenUnit == Constants.customUnitChoice {
            return customUnitRow.text
        } else {
            return chosenUnit
        }
    }
    
    fileprivate func unitsRowSetup() {
        unitsRow = InlinePickerRowFormer<FormInlinePickerCell, String>(cellSetup: {
            $0.titleLabel.text = "Units"
        })
        unitsRow.configure { (row) in
            row.pickerItems = units.map {
                InlinePickerItem(title: $0)
            }
        }
        unitsRow.onValueChanged { (item: InlinePickerItem) in
            if item.title == Constants.customUnitChoice {
                //allow custom pricing unit
                self.former.insertUpdate(rowFormer: self.customUnitRow, below: self.unitsRow)
            }
        }
        
        let _ = append(rows: [unitsRow], headerTitle: "Units")
        
        removeCustomUnitRow(units: units)
    }
    
    fileprivate func removeCustomUnitRow(units: [String]) {
        former.didEndDisplayingCell { (indexPath) in
            //TODO: this is very unsafe code because if I move rows around, then this would break.
            if indexPath.section == 1 && indexPath.row == 1 {
                //For some reason, I couldn't put this in the on valueChanged, because every time the value changed, it would close the picker when updating. Now, I wait until it at least closes to hide it.
                let lastCustomIndex = units.count - 1
                if self.unitsRow.selectedRow != lastCustomIndex {
                    self.former.removeUpdate(rowFormer: self.customUnitRow)
                }
            }
        }
    }
    
    fileprivate func customUnitSetup() {
        customUnitRow = TextFieldRowFormer<FormTextFieldCell>()
        customUnitRow.configure { row in
            row.placeholder = "custom pricing unit..."
        }
    }
}
