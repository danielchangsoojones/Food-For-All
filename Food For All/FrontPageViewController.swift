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
    var theSearchView: MainSearchView?
    
    var dataStore: FrontPageDataStore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        navBarSetup()
        addTableViewVC()
        dataStoreSetup()
        searchBarSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let searchView = theSearchView {
            self.navBar?.addSubview(searchView)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        theSearchView?.removeFromSuperview()
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
        dataStore = FrontPageDataStore(delegate: self)
    }
    
    fileprivate func addTableViewVC() {
        tableVC = FreelancersTableViewController.add(to: self, toView: self.view)
    }
}

//search bar extension
extension FrontPageViewController: MainSearchViewDelegate {
    fileprivate func searchBarSetup() {
        let frame: CGRect = navBar?.bounds ?? CGRect.zero
        let insetFrame = frame.insetBy(dx: 10, dy: 6)
        theSearchView = MainSearchView(frame: insetFrame, delegate: self)
        theSearchView?.theClearButton.addTarget(self, action: #selector(resetSearch), for: .touchUpInside)
        if let searchView = theSearchView {
            self.navBar?.addSubview(searchView)
        }
        theSearchView?.showClearButton()
    }
    
    func resetSearch() {
        dataStore?.loadDefaultGigs()
        theSearchView?.reset()
    }
    
    func handleTap() {
        let searchVC = MainSearchViewController()
        pushVC(searchVC)
    }
    
    fileprivate func navBarSetup() {
        addNavBarGradient()

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

extension FrontPageViewController: FrontPageDataStoreDelegate {
    func pass(gigs: [Gig]) {
        tableVC.gigs = gigs
        tableVC.tableView.reloadData()
    }
}
