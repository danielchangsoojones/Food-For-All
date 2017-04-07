//
//  SettingsViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import Former
import CoreLocation

class SettingsViewController: FormViewController {
    var dataStore: SettingsDataStore? = SettingsDataStore()
    
    //TODO: the nav bar is transparent and we need it to be solid
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutSetup()
        setLocationSetup()
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
    fileprivate func setLocationSetup() {
        let locationRow = LabelRowFormer<FormLabelCell>()
            .configure { row in
                row.text = "Location"
                self.setZipCodeText(row: row)
            }.onSelected { row in
                self.pushVC(SetLocationViewController())
        }
        let section = SectionFormer(rowFormer: locationRow)
        former.append(sectionFormer: section)
    }
    
    fileprivate func setZipCodeText(row: LabelRowFormer<FormLabelCell>) {
        if let location = User.current()?._location {
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    return
                }
                
                if placemarks!.count > 0 {
                    let pm = placemarks![0]
                    
                    row.update({ (row) in
                        row.subText = pm.postalCode
                    })
                } else {
                    print("Problem with the data received from geocoder")
                }
            })
        }
    }
}
