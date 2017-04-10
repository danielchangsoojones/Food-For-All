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
    var theLocationRow: LabelRowFormer<FormLabelCell>!
    
    var dataStore: SettingsDataStore? = SettingsDataStore()
    var contactHelper: ContactHelper?
    
    //TODO: the nav bar is transparent and we need it to be solid
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutSetup()
        setLocationSetup()
        contactUsSetup()
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

extension SettingsViewController: SettingsLocationVCDelegate {
    fileprivate func setLocationSetup() {
        theLocationRow = LabelRowFormer<FormLabelCell>()
            .configure { row in
                row.text = "Location"
                self.setZipCodeText(row: row)
            }.onSelected { row in
                self.locationRowPressed()
        }
        let section = SectionFormer(rowFormer: theLocationRow)
        former.append(sectionFormer: section)
    }
    
    fileprivate func locationRowPressed() {
        let locationVC = SettingsLocationViewController()
        locationVC.delegate = self
        pushVC(locationVC)
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
    
    func update(zipCode: String) {
        theLocationRow.update { (row) in
            row.subText = zipCode
        }
    }
}

extension SettingsViewController {
    fileprivate func contactUsSetup() {
        let contactUsRow = LabelRowFormer<FormLabelCell>()
            .configure { row in
                row.text = "Contact Us"
            }.onSelected { row in
                self.contactUsPressed()
        }
        let section = SectionFormer(rowFormer: contactUsRow)
        former.append(sectionFormer: section)
    }
    
    fileprivate func contactUsPressed() {
        //need to hold contactHelper in global variable because it uses a message helper which needs to still be alive when the function finished because it is a long running operation to open up a message.
        contactHelper = ContactHelper()
        contactHelper?.contactUs(currentVC: self)
    }
}

