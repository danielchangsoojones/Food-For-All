//
//  CustomTabBarController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/31/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [firstVC, secondVC, thirdVC]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//first view controller
extension CustomTabBarController {
    var firstTabBarItem: UITabBarItem {
        let item = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Home"), tag: 1)
        return item
    }
    
    var firstVC: UIViewController {
        let vc = FrontPageViewController()
        vc.tabBarItem = firstTabBarItem
        let navController = CustomNavigationController(rootViewController: vc)
        return navController
    }
}

//second view controller
extension CustomTabBarController {
    var secondTabBarItem: UITabBarItem {
        let item = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "TabBarAdd"), tag: 2)
        return item
    }
    
    var secondVC: UIViewController {
        let vc = UIViewController()
        vc.tabBarItem = secondTabBarItem
        return vc
    }
}

extension CustomTabBarController {
    var thirdTabBarItem: UITabBarItem {
        let item = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "Profile"), tag: 3)
        return item
    }
    
    var thirdVC: UIViewController {
        let vc = UIViewController()
        vc.tabBarItem = thirdTabBarItem
        return vc
    }
}
