//
//  CustomNavigationController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    struct Constants {
        static let navBarTintColor: UIColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = Constants.navBarTintColor //makes the back button a certain color
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        CustomNavigationController.createCustomBackButton(navController: self)
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let poppedVC = super.popViewController(animated: animated)
        if viewControllers.count == 1 {
            //down to the rootVC
            tabBarController?.tabBar.isHidden = false
        }
        return poppedVC
    }
    
    func makeTransparent() {
        CustomNavigationController.makeTransparent(navBar: navigationBar)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public func popViewController(animated: Bool, completion: (() -> Void)?) -> UIViewController? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        
        let controller = self.popViewController(animated: animated)
        
        CATransaction.commit()
        
        return controller
    }
}

extension CustomNavigationController {
    static func createCustomBackButton(navController: UINavigationController) {
        //when we push a new view controller, we want to have a a custom back button.
        //To set the back item for a View Controller, you need to set the back item in the previous ViewController, hence why I am setting it here. YOu can't set it in the destinationVC or it is too late
        //This allows us to have the same backButton throughout the app
        if navController.viewControllers.count >= 1 {
            let pushingVC = navController.viewControllers[navController.viewControllers.count - 1]
            let backItem = UIBarButtonItem()
            backItem.title = "" //get rid of the title, we just want the back arrow: <
            pushingVC.navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
            navController.tabBarController?.tabBar.isHidden = true
        }
    }
    
    static func makeTransparent(navBar: UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
    }
}
