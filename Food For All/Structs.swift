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

struct CustomColors {
    static let JellyTeal: UIColor = UIColor(r: 1, g: 195, b: 167)
    static let Polar: UIColor = UIColor(r: 204, g: 243, b: 237)
    
    static let welcomeGradientColors: [CGColor] = [CustomColors.JellyTeal.cgColor, CustomColors.Polar.cgColor]
    
    static func addGradient(colors: [CGColor], to view: UIView) {
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = view.frame.size
        gradient.colors = colors
        view.layer.insertSublayer(gradient, at: 0)
//        view.layer.addSublayer(gradient)
    }
}
