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
    var priceRow = SliderRowFormer<FormSliderCell>()

    override func viewDidLoad() {
        super.viewDidLoad()
        priceRowSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension PricingFormViewController {
    fileprivate func priceRowSetup() {
        priceRow.configure { (row) in
            row.cell.slider.maximumValue = 100
            row.cell.slider.minimumValue = 0
            row.onValueChanged({ (value: Float) in
                let roundedValue = Int(value)
                row.cell.displayLabel.text = roundedValue.toString + " $"
            })
        }
        append(rows:[priceRow], headerTitle: "Pricing")
    }
}
