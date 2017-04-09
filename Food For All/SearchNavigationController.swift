//
//  SearchNavigationController.swift
//  Food For All
//
//  Created by Daniel Jones on 4/8/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import AMScrollingNavbar

class SearchNavigationController: ScrollingNavigationController {
    //Not sure why, but in order to use the navigation bar class, we need to implement this initializer also
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    init() {
        super.init(navigationBarClass: SearchNavigationBar.self, toolbarClass: nil)
        setEnlargedSearchNavigationBar()
        setViewControllers([TransactionFeedViewController()], animated: false) //setting root view controller
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white //so when we change the nav bar height it doesn't have weird blackness.
    }
    
    fileprivate func setEnlargedSearchNavigationBar() {
        navigationBar.frame = CGRect(x: 0, y: 0, width: navigationBar.bounds.width, height: SearchNavigationBar.enlargedHeight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count == 1 {
            //pushing from root view controller
            let height: CGFloat = 50 //whatever height you want
            self.navigationBar.frame = CGRect(x: 0, y: 0, width: self.navigationBar.bounds.width, height: height)
            navigationBar.removeSubviews()
            makeTransparent()
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    fileprivate func makeTransparent() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        if viewControllers.count == 2 {
            //popping to root view controller
            setEnlargedSearchNavigationBar()
        }
        return super.popViewController(animated: animated)
    }
}
