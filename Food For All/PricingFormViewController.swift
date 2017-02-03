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
    var priceRow: SliderRowFormer<FormSliderCell>!
    var unitsRow: InlinePickerRowFormer<FormInlinePickerCell, String>!
    var customUnitRow: TextFieldRowFormer<FormTextFieldCell>!
    
    var isShowingCustomUnitRow: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        priceRowSetup()
        unitsRowSetup()
        customUnitSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PricingFormViewController {
    fileprivate func priceRowSetup() {
        priceRow = SliderRowFormer<FormSliderCell>()
        priceRow.configure { (row) in
            row.cell.slider.maximumValue = 100
            row.cell.slider.minimumValue = 0
            row.onValueChanged({ (value: Float) in
                let roundedValue = Int(value)
                row.cell.displayLabel.text = roundedValue.toString + " $"
            })
        }
        _ = append(rows:[priceRow], headerTitle: "Pricing")
    }
    
    fileprivate func unitsRowSetup() {
        let units = ["per hour", "per session", "per job", "create custom"]
        unitsRow = InlinePickerRowFormer<FormInlinePickerCell, String>(cellSetup: {
            $0.titleLabel.text = "Units"
        })
        unitsRow.configure { (row) in
            row.pickerItems = units.map {
                InlinePickerItem(title: $0)
            }
        }
        unitsRow.onValueChanged { (item: InlinePickerItem) in
            if item.title == units.last {
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
