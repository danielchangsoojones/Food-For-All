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
}


