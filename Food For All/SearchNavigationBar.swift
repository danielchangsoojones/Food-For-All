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
    
    var theCollectionView: UICollectionView?
    var theSearchView: MainSearchView?
    
    var navDelegate: SearchNavBarDelegate?
    
    var hasSearchViews: Bool {
        if let collectionView = theCollectionView, let searchView = theSearchView {
            let hasCollectionView: Bool = subviews.contains(collectionView)
            let hasMainSearchView: Bool = subviews.contains(searchView)
            return hasCollectionView && hasMainSearchView
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

//collection View extension
extension SearchNavigationBar {
    func collectionViewSetup(delegate: UICollectionViewDelegateFlowLayout, dataSource: UICollectionViewDataSource) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let minY = theSearchView?.frame.maxY ?? 0
        theCollectionView = UICollectionView(frame: CGRect(x: 0, y: minY, w: self.frame.width, h: SearchNavigationBar.enlargedHeight * SearchNavigationBar.subviewRatio), collectionViewLayout: layout)
        theCollectionView?.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        theCollectionView?.delegate = delegate
        theCollectionView?.dataSource = dataSource
        theCollectionView?.backgroundColor = UIColor.clear
        theCollectionView?.showsHorizontalScrollIndicator = false
        theCollectionView?.contentInset.left = Constants.horizontalInset
        if let collectionView = theCollectionView {
            self.addSubview(collectionView)
        }
    }
}

extension SearchNavigationBar {
    static let subviewRatio: CGFloat = 0.5
    static let enlargedHeight: CGFloat = 120
}
