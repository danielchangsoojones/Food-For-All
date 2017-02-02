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
    override func viewDidLoad() {
        super.viewDidLoad()
        let labelRow = TextViewRowFormer<FormTextViewCell>()
            .configure { row in
                row.placeholder = "Describe your service/qualifications..."
            }.onSelected { row in
                // Do Something
            }
        let header = LabelViewFormer<FormLabelHeaderView>()
        header.text = "Label Header"
        
        let section = SectionFormer(rowFormer: labelRow)
            .set(headerViewFormer: header)
        former.append(sectionFormer: section)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
