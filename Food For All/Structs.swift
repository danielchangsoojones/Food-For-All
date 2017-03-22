//
//  Structs.swift
//  Food For All
//
//  Created by Daniel Jones on 1/10/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit
import EZSwiftExtensions
import BRYXBanner
import Parse

struct CustomColors {
    static let JellyTeal: UIColor = UIColor(r: 1, g: 195, b: 167)
    static let Polar: UIColor = UIColor(r: 204, g: 243, b: 237)
    static let SilverChalice: UIColor = UIColor(r: 178, g: 178, b: 178)
    static let BombayGray: UIColor = UIColor(r: 212, g: 213, b: 215)
    static let AquamarineBlue: UIColor = UIColor(r: 108, g: 223, b: 214)
    static let GrannySmithGreen: UIColor = UIColor(r: 165, g: 223, b: 160)
    
    static let welcomeGradientColors: [CGColor] = [CustomColors.JellyTeal.cgColor, CustomColors.Polar.cgColor]
    static let searchBarGradientColors: [CGColor] = [CustomColors.AquamarineBlue.cgColor, CustomColors.JellyTeal.cgColor]
    static let creationGradientColors: [CGColor] = [CustomColors.AquamarineBlue.cgColor, CustomColors.GrannySmithGreen.cgColor]
    
    static func addGradient(colors: [CGColor], to view: UIView, startPoint: CGPoint? = nil, endPoint: CGPoint? = nil) {
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = view.frame.size
        gradient.colors = colors
        if let startPoint = startPoint {
            gradient.startPoint = startPoint
        }
        if let endPoint = endPoint {
            gradient.endPoint = endPoint
        }
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    static func addNavBarGradient(navController: UINavigationController?) {
        if let navController = navController {
            let gradientLayer = CAGradientLayer()
            var updatedFrame = navController.navigationBar.bounds
            updatedFrame.size.height += 20 //for the status bar height, not sure what this line is doing?
            gradientLayer.frame = updatedFrame
            gradientLayer.colors = CustomColors.searchBarGradientColors
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
            UIGraphicsBeginImageContext(gradientLayer.bounds.size)
            gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            navController.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        }
    }
}

struct Helpers {
    enum BannerType {
        case error
        case success
    }
    
    
    static func showBanner(title: String, subtitle: String, bannerType: BannerType = .error, duration: TimeInterval = 10) {
        var backgroundColor: UIColor = UIColor.red
        switch bannerType {
        case .error:
            backgroundColor = UIColor.red
        case .success:
            backgroundColor = UIColor.green
        }
        
        let banner = Banner(title: title, subtitle: subtitle, backgroundColor: backgroundColor)
        banner.dismissesOnTap = true
        banner.show(duration: duration)
    }
    
    static var line: UIView {
        let line = UIView(frame: CGRect(x: 0, y: 0, w: 0, h: 1))
        line.backgroundColor = CustomColors.SilverChalice
        line.alpha = 0.5
        return line
    }
    
    static func showActivityIndicatory(uiView: UIView) -> UIView {
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0.0, y: 0.0, w: 80.0, h: 80.0)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(r: 0.25, g: 0.25, b: 0.25, a: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, w: 40.0, h: 40.0)
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
        
        return container
    }
    
    //Filename should be something like "profileImage.jpg"
    static func saveImageAsPFFIle(fileName: String, image: Any?) -> PFFile? {
        if let image = image as? UIImage, let data = UIImageJPEGRepresentation(image, 0.6) {
            let pictureFile = PFFile(name: fileName, data: data)
            return pictureFile
        }
        return nil
    }
    
        
    static func EmptyMessage(message: String, viewController: UITableViewController) {
        Helpers.EmptyMessage(message: message, tableView: viewController.tableView)
    }
    
    static func EmptyMessage(message: String, tableView: UITableView) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height))
        messageLabel.text = message
        let bubbleColor = UIColor(red: CGFloat(57)/255, green: CGFloat(81)/255, blue: CGFloat(104)/255, alpha :1)
        
        messageLabel.textColor = bubbleColor
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 18)
        messageLabel.sizeToFit()
        
        tableView.backgroundView = messageLabel
    }
    
    static func stylizeButton(text: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = CustomColors.Polar
        button.setTitle(text, for: .normal)
        button.titleLabel!.font =  UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        button.setTitleColor(CustomColors.SilverChalice, for: .normal)
        let horizontalInset: CGFloat = 30
        let verticalInset: CGFloat = 10
        button.contentEdgeInsets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        button.setCornerRadius(radius: 15)
        return button
    }
    
    static func enterApplication(from vc: UIViewController) {
        let tabBarController = CustomTabBarController()
        vc.presentVC(tabBarController)
    }
    
    static func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            return keyboardHeight
        }
        return 0
    }
    
    static func showNewPhotoChoices(vc: UIViewController, shouldCrop: Bool = false) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (alertAction: UIAlertAction) in
            if shouldCrop {
                if let delegate = vc as? CameraDelegate {
                    Camera(delegate: delegate).presentCroppingPhotoLibraryVC(target: vc)
                }
            } else {
                _ = Camera.shouldStartPhotoLibrary(target: vc as AnyObject, canEdit: false)
            }
        }
        
        let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { (alertAction: UIAlertAction) in
            //If you are on mac simulator, then the camera crashes because mac doesn't have a camera on simulator, only photo library.
            if shouldCrop {
                if let delegate = vc as? CameraDelegate {
                    Camera(delegate: delegate).presentCroppingCameraVC(target: vc)
                }
            } else {
                _ = Camera.shouldStartCamera(target: vc, canEdit: false, frontFacing: true)
            }
        }
        
        alert.addAction(photoLibraryAction)
        alert.addAction(cameraAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func randomString(length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    static var categories: [String] = ["Tutoring", "Laundry", "Haircuts", "Photography", "Other"]
    
    static func venmoTapped(gig: Gig) {
        let venmoUsername: String? = gig.creator.venmoUsername
        let headURL = "https://venmo.com/"
        
        var venmoState: String = "pressed, but no venmo account attatched"
        if let venmoUsername = venmoUsername {
            if let destinationURL = URL(string: headURL + venmoUsername), UIApplication.shared.canOpenURL(destinationURL) {
                UIApplication.shared.openURL(destinationURL)
            } else {
                Helpers.showBanner(title: "Error", subtitle: "Venmo could not be loaded", bannerType: .error)
            }
            venmoState = "success"
        } else {
            //the gig creator never made a username
            Helpers.showBanner(title: "Error", subtitle: "The freelancer has not configured their venmo account yet", bannerType: .error)
        }
        
        let dataStore = ContractDataStore()
        dataStore.saveVenmoMetric(state: venmoState, gig: gig)
    }
}

struct PhoneValidator {
    static func format(phoneNumber sourcePhoneNumber: String) -> String? {
        
        // Remove any character that is not a number
        let numbersOnly = sourcePhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let length = numbersOnly.characters.count
        let hasLeadingOne = numbersOnly.hasPrefix("1")
        
        // Check for supported phone number length
        guard length == 7 || length == 10 || (length == 11 && hasLeadingOne) else {
            return nil
        }
        
        let hasAreaCode = (length >= 10)
        var sourceIndex = 0
        
        // Leading 1
        var leadingOne = ""
        if hasLeadingOne {
            leadingOne = "1 "
            sourceIndex += 1
        }
        
        // Area code
        var areaCode = ""
        if hasAreaCode {
            let areaCodeLength = 3
            guard let areaCodeSubstring = numbersOnly.characters.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
                return nil
            }
            areaCode = String(format: "(%@) ", areaCodeSubstring)
            sourceIndex += areaCodeLength
        }
        
        // Prefix, 3 characters
        let prefixLength = 3
        guard let prefix = numbersOnly.characters.substring(start: sourceIndex, offsetBy: prefixLength) else {
            return nil
        }
        sourceIndex += prefixLength
        
        // Suffix, 4 characters
        let suffixLength = 4
        guard let suffix = numbersOnly.characters.substring(start: sourceIndex, offsetBy: suffixLength) else {
            return nil
        }
        
        return leadingOne + areaCode + prefix + "-" + suffix
    }
    
    static func isValidPhoneNumber(phoneString: String?) -> Bool {
        if let phoneString = phoneString {
            //To make sure that any Doubles don't use a phone number with .0 (i.e. 3176905323.0)
            if (phoneString.characters.count == 10 || phoneString.characters.count == 11) {
                return true
            }
        }
        
        return false
    }
}

extension String.CharacterView {
    /// This method makes it easier extract a substring by character index where a character is viewed as a human-readable character (grapheme cluster).
    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
        
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[substringStartIndex ..< substringEndIndex])
    }
}


