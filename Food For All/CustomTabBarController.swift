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
        item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
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
        let image = #imageLiteral(resourceName: "TabBarAdd").withRenderingMode(.alwaysOriginal)
        let item = UITabBarItem(title: nil, image: image, tag: 2)
        item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
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
        item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        return item
    }
    
    var thirdVC: UIViewController {
        let vc = UIViewController()
        vc.tabBarItem = thirdTabBarItem
        return vc
    }
}
