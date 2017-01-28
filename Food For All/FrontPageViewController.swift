//
//  FrontPageViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/22/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class FrontPageViewController: UIViewController {
    var tableVC: FreelancersTableViewController!
    var theSearchView: MainSearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        navBarSetup()
        addTableViewVC()
        dataStoreSetup()
        searchBarSetup()
    }

    fileprivate func viewSetup() {
        let frontPageView = FrontPageView(frame: self.view.bounds)
        self.view = frontPageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func dataStoreSetup() {
        let _ = FrontPageDataStore(delegate: self)
    }
    
    fileprivate func addTableViewVC() {
        tableVC = FreelancersTableViewController.add(to: self, toView: self.view)
    }
    
    fileprivate func navBarSetup() {
        addNavBarGradient()
        
        //make title label white
        self.navBar?.barStyle = UIBarStyle.black
        self.navBar?.tintColor = UIColor.white
        
        //remove nav bar line
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func addNavBarGradient() {
        let gradientLayer = CAGradientLayer()
        var updatedFrame = self.navigationController?.navigationBar.bounds ?? CGRect.zero
        updatedFrame.size.height += 20
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

//search bar extension
extension FrontPageViewController {
    fileprivate func searchBarSetup() {
        let frame: CGRect = navBar?.bounds ?? CGRect.zero
        let insetFrame = frame.insetBy(dx: 10, dy: 6)
        theSearchView = MainSearchView(frame: insetFrame)
        theSearchView.showClearButton()
        theSearchView.theClearButton.addTarget(self, action: #selector(resetSearch), for: .touchUpInside)
        self.navBar?.addSubview(theSearchView)
    }
    
    func resetSearch() {
        theSearchView.reset()
    }
}

extension FrontPageViewController: FrontPageDataStoreDelegate {
    func pass(gigs: [Gig]) {
        tableVC.gigs = gigs
        tableVC.tableView.reloadData()
    }
}
