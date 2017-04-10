//
//  SearchNavigationController.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import EZSwiftExtensions

class SearchNavigationController: ScrollingNavigationController {
    //Not sure why, but in order to use the navigation bar class, we need to implement this initializer also
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init() {
        super.init(navigationBarClass: SearchNavigationBar.self, toolbarClass: nil)
        self.navigationBar.barStyle = UIBarStyle.black //white view controller title
        setEnlargedSearchNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white //so when we change the nav bar height it doesn't have weird blackness.
        navigationBar.tintColor = UIColor.white
    }
    
    fileprivate func setEnlargedSearchNavigationBar() {
        navigationBar.frame = CGRect(x: 0, y: 0, width: navigationBar.bounds.width, height: SearchNavigationBar.enlargedHeight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count == 1 {
            //pushing from root view controller
            //TODO: this is manually calculating nav bar height with a constant, if apple ever changes nav bar height, then this would break.
            var navBarHeight: CGFloat = 44
            if !viewController.prefersStatusBarHidden {
                navBarHeight += ez.screenStatusBarHeight
            }
            navigationBar.frame = CGRect(x: 0, y: 0, w: self.navigationBar.bounds.width, h: navBarHeight)
            removeSearchSubviews()
            CustomNavigationController.makeTransparent(navBar: navigationBar)
        }
        CustomNavigationController.createCustomBackButton(navController: self)
        super.pushViewController(viewController, animated: animated)
    }
    
    fileprivate func removeSearchSubviews() {
        for subview in navigationBar.subviews {
            if subview is MainSearchView || subview is UICollectionView {
                subview.removeFromSuperview()
            }
        }
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if viewControllers.count == 2, let poppingVC = viewControllers.last {
            //popping to root view controller
            setEnlargedSearchNavigationBar()
            if !poppingVC.prefersStatusBarHidden {
                //TODO: For some reason, when I pop from a vc with a status bar, it makes the Search View go on top of the status bar. Not sure why, but accounting for the status bar fixes it here. It works fine for VC's without a status bar.
                navigationBar.frame.y = ez.screenStatusBarHeight
            }
            tabBarController?.tabBar.isHidden = false
        }
        return super.popViewController(animated: animated)
    }
}
