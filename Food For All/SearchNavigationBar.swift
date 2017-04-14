//
//  SearchNavigationBar.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

protocol SearchNavBarDelegate {
    func searchTapped()
}

class SearchNavigationBar: UINavigationBar {
    struct Constants {
        static let horizontalInset: CGFloat = 10
    }
    
    var theSearchView: MainSearchView?
    
    var navDelegate: SearchNavBarDelegate?
    
    var hasSearchViews: Bool {
        if let searchView = theSearchView {
            let hasMainSearchView: Bool = subviews.contains(searchView)
            return hasMainSearchView
        }
        
        return false
    }
    
    //allows us to set a customized height for the navigation controller
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let newSize : CGSize = CGSize(width: self.frame.size.width, height: self.frame.height)
        return newSize
    }
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        var updatedFrame = self.bounds
        updatedFrame.size.height += 20 //for the status bar height, not sure what this line is doing?
        gradientLayer.frame = updatedFrame
        gradientLayer.colors = CustomColors.searchBarGradientColors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(image, for: UIBarMetrics.default)
    }
}

//search view extension
extension SearchNavigationBar {
    func addSearchView() {
        //TODO: technically, since we got rid of the tag collectionview, we don't even need to resize the nav bar everytime, but this might change at some point
        let frame: CGRect = CGRect(x: 0, y: 0, w: self.frame.width, h: SearchNavigationBar.enlargedHeight * SearchNavigationBar.subviewRatio)
        let insetFrame = frame.insetBy(dx: Constants.horizontalInset, dy: 6)
        theSearchView = MainSearchView(frame: insetFrame)
        theSearchView?.addTapGesture(target: self, action: #selector(searchTapped))
        if let searchView = theSearchView {
            self.addSubview(searchView)
        }
    }
    
    func searchTapped() {
        navDelegate?.searchTapped()
    }
}

extension SearchNavigationBar {
    static let subviewRatio: CGFloat = 1
    static let enlargedHeight: CGFloat = 55
}
