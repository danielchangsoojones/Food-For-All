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

struct CustomColors {
    static let JellyTeal: UIColor = UIColor(r: 1, g: 195, b: 167)
    static let Polar: UIColor = UIColor(r: 204, g: 243, b: 237)
    static let SilverChalice: UIColor = UIColor(r: 178, g: 178, b: 178)
    static let AquamarineBlue: UIColor = UIColor(r: 108, g: 223, b: 214)
    static let GrannySmithGreen: UIColor = UIColor(r: 165, g: 223, b: 160)
    
    static let welcomeGradientColors: [CGColor] = [CustomColors.JellyTeal.cgColor, CustomColors.Polar.cgColor]
    static let searchBarGradientColors: [CGColor] = [CustomColors.AquamarineBlue.cgColor, CustomColors.JellyTeal.cgColor]
    
    static func addGradient(colors: [CGColor], to view: UIView) {
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = view.frame.size
        gradient.colors = colors
        view.layer.insertSublayer(gradient, at: 0)
    }
}

struct Helpers {
    enum BannerType {
        case error
        case success
    }
    
    
    static func showBanner(title: String, subtitle: String, bannerType: BannerType = .error) {
        var backgroundColor: UIColor = UIColor.red
        switch bannerType {
        case .error:
            backgroundColor = UIColor.red
        case .success:
            backgroundColor = UIColor.green
        }
        
        let banner = Banner(title: title, subtitle: subtitle, backgroundColor: backgroundColor)
        banner.dismissesOnTap = true
        banner.show(duration: 10.0)
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
}


