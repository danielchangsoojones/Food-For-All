//
//  TransactionFeedVCSearchExtension.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import Foundation
import UIKit

extension TransactionFeedViewController {
        fileprivate func searchBarSetup() {
//            let frame: CGRect = navBar?.bounds ?? CGRect.zero
//            let insetFrame = frame.insetBy(dx: 10, dy: 6)
//            theSearchView = MainSearchView(frame: insetFrame, delegate: self)
//            theSearchView?.theClearButton.addTarget(self, action: #selector(resetSearch), for: .touchUpInside)
//            if let searchView = theSearchView {
//                self.navBar?.addSubview(searchView)
//            }
        }
    
    func handleTap() {
        let searchVC = MainSearchingViewController()
        if let category = SearchCategory(rawValue: title ?? "") {
            searchVC.searchCategory = category
        }
        pushVC(searchVC)
    }
    
    fileprivate func navBarSetup() {
        addNavBarGradient()
        
        //remove nav bar line
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func addNavBarGradient() {
        let gradientLayer = CAGradientLayer()
        var updatedFrame = self.navigationController?.navigationBar.bounds ?? CGRect.zero
        updatedFrame.size.height += 20 //for the status bar height, not sure what this line is doing?
        gradientLayer.frame = updatedFrame
        gradientLayer.colors = CustomColors.searchBarGradientColors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.navigationController!.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
    }
}
