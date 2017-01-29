//
//  MainSearchingViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/28/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import EZSwiftExtensions

struct MainSearchingViewConstants {
    static let leadingInset: CGFloat = 15
}

class MainSearchingViewController: UIViewController {
    var theSearchBar: CustomSearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        navBarSetup()
    }
    
    fileprivate func viewSetup() {
        let searchingView = MainSearchingView(frame: self.view.bounds, navBarHeight: navigationBarHeight + ez.screenStatusBarHeight)
        self.view = searchingView
        searchingView.theTableView.delegate = self
        searchingView.theTableView.dataSource = self
        theSearchBar = searchingView.theSearchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

//navigation bar extension
extension MainSearchingViewController {
    fileprivate func navBarSetup() {
        if let customNav = self.navigationController as? CustomNavigationController {
            customNav.makeTransparent()
        }
        leftBarButtonSetup()
    }
    
    fileprivate func leftBarButtonSetup() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "X"), style: .done, target: self, action: #selector(leftBarButtonTapped))
    }
    
    func leftBarButtonTapped() {
        popVC()
    }
}

extension MainSearchingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MainSearchTableViewCell(title: "Testing")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
