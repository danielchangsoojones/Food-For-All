//
//  CustomTabBarController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/31/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    struct Titles {
        static let creationVC: String = "creationVC"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: change names from firstVC to the actual description of the view controller
        viewControllers = [firstVC, categoryVC, secondVC, thirdVC]
        delegate = self
        tabBar.tintColor = CustomColors.JellyTeal
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTabBarItem(image: UIImage, tag: Int) -> UITabBarItem {
        let item = UITabBarItem(title: nil, image: image, tag: tag)
        item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        return item
    }
}

//delegate methods
extension CustomTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.title == Titles.creationVC {
            //The creationVC should not show the tab bar, we want it to present the creation stuff over the whole screen, like instagram/flipagram does, and then they can hit X in the corner to exit.
            let vcToPresent = creationNavController //need to make a new VC, can't re-present the creationVC or else crash
            present(vcToPresent, animated: true, completion: nil)
            return false
        }
        
        return true
    }
}

//first view controller
extension CustomTabBarController {
    var firstTabBarItem: UITabBarItem {
        return createTabBarItem(image: #imageLiteral(resourceName: "Home"), tag: 1)
    }
    
    var firstVC: UIViewController {
        let vc = TransactionFeedViewController()
        vc.tabBarItem = firstTabBarItem
        let navController = SearchNavigationController()
        navController.setViewControllers([vc], animated: false) //setting root view controller
        return navController
    }
}

//second view controller
extension CustomTabBarController {
    var secondTabBarItem: UITabBarItem {
        let image = #imageLiteral(resourceName: "TabBarAdd")
        return createTabBarItem(image: image, tag: 3)
    }
    
    var secondVC: UIViewController {
        let vc = UIViewController() //placholder vc, so we can have a modal segue to creationVC
        vc.title = Titles.creationVC
        vc.tabBarItem = secondTabBarItem
        return vc
    }
    
    var creationNavController: UINavigationController {
        let rootVC = CreationViewController()
        let clearNavController = ClearNavigationController(rootViewController: rootVC)
        return clearNavController
    }
}

extension CustomTabBarController {
    var thirdTabBarItem: UITabBarItem {
        return createTabBarItem(image: #imageLiteral(resourceName: "Profile"), tag: 4)
    }
    
    var thirdVC: UIViewController {
        let vc = ProfileViewController()
        vc.tabBarItem = thirdTabBarItem
        let clearNavController = ClearNavigationController(rootViewController: vc)
        return clearNavController
    }
}

extension CustomTabBarController {
    var categoryTabBarItem: UITabBarItem {
        return createTabBarItem(image: #imageLiteral(resourceName: "Earth"), tag: 2)
    }
    
    var categoryVC: UIViewController {
        let vc = CategoriesViewController()
        vc.tabBarItem = categoryTabBarItem
        let navController = ClearNavigationController(rootViewController: vc)
        return navController
    }
}
