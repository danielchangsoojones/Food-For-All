//
//  CustomNavigationController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = UIColor.white //makes the back button a certain color
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //when we push a new view controller, we want to have a a custom back button.
        //To set the back item for a View Controller, you need to set the back item in the previous ViewController, hence why I am setting it here. YOu can't set it in the destinationVC or it is too late
        //This allows us to have the same backButton throughout the app
        if viewControllers.count >= 1 {
            let pushingVC = viewControllers[viewControllers.count - 1]
            let backItem = UIBarButtonItem()
            backItem.title = "" //get rid of the title, we just want the back arrow: <
            pushingVC.navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func makeTransparent() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
