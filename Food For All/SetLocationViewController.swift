//
//  SetLocationViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 4/5/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SCLAlertView

class SetLocationViewController: UIViewController {
    var theKeyboardAccessoryView: UIView!
    var theZipCodeTextField: UITextField!
    
    let locationManager = CLLocationManager()
    var chosenLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        title = "Set Location"
        //To show the input accessory view initially
        self.becomeFirstResponder()
        CustomColors.addGradient(colors: CustomColors.creationGradientColors, to: self.view)
    }
    
    fileprivate func viewSetup() {
        let locationView = SetLocationView(frame: self.view.bounds)
        self.view = locationView
        theKeyboardAccessoryView = locationView.theKeyboardAccessoryView
        locationView.theSaveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        theZipCodeTextField = locationView.theZipCodeTextField
        theZipCodeTextField.delegate = self
        locationView.theLocationButton.addTarget(self, action: #selector(currentLocationButtonPressed), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //To show the input accessory view initially
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputAccessoryView: UIView? {
        return theKeyboardAccessoryView
    }
    
    func finishedSaving() {
        Helpers.enterApplication(from: self)
    }
}

//save extension
extension SetLocationViewController {
    func savePressed() {
        if isValidZipCode() {
            if let chosenLocation = chosenLocation {
                //user chose location from current location
                save(location: chosenLocation)
            } else {
                //get location from zip code
                getLocationFromZipCode()
            }
        }
    }
    
    fileprivate func getLocationFromZipCode() {
        let address = "46032"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks, let first = placemarks.first, let targetLocation = first.location {
                self.save(location: targetLocation)
            } else if error != nil {
                Helpers.showBanner(title: "Zip Code Error", subtitle: "Problem saving inputted zip code", bannerType: .error)
            }
        }
    }
    
    func isValidZipCode() -> Bool {
        if theZipCodeTextField.text?.characters.count == 5 {
            //valid zip code
            return true
        } else {
            Helpers.showBanner(title: "Invalid Zip Code", subtitle: "Please enter a valid 5 digit zip code", bannerType: .error)
            return false
        }
    }
    
    fileprivate func save(location: CLLocation) {
        User.current()?._location = location
        User.current()?.saveInBackground()
        finishedSaving()
    }
}

extension SetLocationViewController: CLLocationManagerDelegate {
    func currentLocationButtonPressed() {
        theZipCodeTextField.resignFirstResponder()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .restricted, .denied:
                let alert = SCLAlertView()
                alert.addButton("Settings", action: {
                    //go to apple system settings for our app page, so they can update location
                    let path = UIApplicationOpenSettingsURLString
                    if let settingsURL = URL(string: path), UIApplication.shared.canOpenURL(settingsURL) {
                        UIApplication.shared.openURL(settingsURL)
                    }
                })
                alert.showInfo("Access Location", subTitle: "Please proceed to your settings to update your location services", closeButtonTitle: "Cancel")
            case .authorizedAlways, .authorizedWhenInUse, .notDetermined:
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.requestLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            chosenLocation = location
            updateZipCodeText(from: location)
            //the update location is being called twice, this makes it so it will only be called the first time.
            manager.stopUpdatingLocation()
            manager.delegate = nil
        }
    }
    
    fileprivate func updateZipCodeText(from location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                
                self.theZipCodeTextField.text = pm.postalCode
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Helpers.showBanner(title: "Location Error", subtitle: "Failed to find your location: \(error.localizedDescription)", bannerType: .error)
    }
}

extension SetLocationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        let limitLength = 5
        return newLength <= limitLength // Bool
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        chosenLocation = nil
    }
}

extension SetLocationViewController {
    static func create() -> UINavigationController {
        let clearNavController = ClearNavigationController(rootViewController: SetLocationViewController())
        return clearNavController
    }
}
