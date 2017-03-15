//
//  SettingsViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Former

class SettingsViewController: FormViewController {
    var dataStore: SettingsDataStore? = SettingsDataStore()
    
    //TODO: the nav bar is transparent and we need it to be solid
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutSetup()
        userMetricRowSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//logout extension
extension SettingsViewController {
    fileprivate func logOutSetup() {
        let logOutRow = LabelRowFormer<FormLabelCell>()
            .configure { row in
                row.text = "Log Out"
            }.onSelected { row in
                self.dataStore?.logOut()
                self.segueToWelcomePage()
        }
        let section = SectionFormer(rowFormer: logOutRow)
        former.append(sectionFormer: section)
    }
    
    fileprivate func segueToWelcomePage() {
        let rootVC = WelcomeViewController()
        let navController = ClearNavigationController(rootViewController: rootVC)
        presentVC(navController)
    }
}

extension SettingsViewController {
    fileprivate func userMetricRowSetup() {
        let userMetricRow = LabelRowFormer<FormLabelCell>()
            .configure { row in
                row.text = "Secret!"
            }.onSelected { row in
                self.dataStore?.seeUserMetrics()
        }
        let section = SectionFormer(rowFormer: userMetricRow)
        former.append(sectionFormer: section)
    }
}
