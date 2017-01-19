//
//  WelcomeInputAccessoryView.swift
//  Food For All
//
//  Created by Daniel Jones on 1/16/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

class WelcomeInputAccessoryView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for subview in subviews {
            if subview.frame.contains(point) {
                return subview
            }
        }
        return nil
    }
}
