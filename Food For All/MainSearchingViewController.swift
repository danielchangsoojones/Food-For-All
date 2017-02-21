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

protocol SearchVCDelegate {
    func pass(gigs: [Gig])
}

class MainSearchingViewController: UIViewController {
    var theSearchBar: CustomSearchBar!
    var theTableView: UITableView!
    var theSpinnerView: UIView?
    
    var results: [String] = [] {
        didSet {
            hasLoadedDatabaseOnce = true
        }
    }
    var hasLoadedDatabaseOnce: Bool = false
    
    var searchCategory: SearchCategory = .other
    
    var dataStore: MainSearchingDataStore?
    var delegate: SearchVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        dataStoreSetup()
        navBarSetup()
        setExampleResults()
    }
    
    fileprivate func viewSetup() {
        let searchingView = MainSearchingView(frame: self.view.bounds, navBarHeight: navigationBarHeight + ez.screenStatusBarHeight)
        self.view = searchingView
        theTableView = searchingView.theTableView
        theTableView.delegate = self
        theTableView.dataSource = self
        theSearchBar = searchingView.theSearchBar
        theSearchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func dataStoreSetup() {
        dataStore = MainSearchingDataStore(delegate: self)
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
        return results.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if results.isEmpty && hasLoadedDatabaseOnce {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "No results found"
            noDataLabel.textColor = UIColor.white
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
        } else {
            numOfSections = 1
            tableView.backgroundView = nil
        }
        return numOfSections
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = results[indexPath.row]
        let cell = MainSearchTableViewCell(title: result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        theSpinnerView = Helpers.showActivityIndicatory(uiView: self.view)
        let result = results[indexPath.row]
        dataStore?.findGigs(title: result)
    }
    
    fileprivate func setExampleResults() {
        results = searchCategory.searchTips
    }
}

extension MainSearchingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataStore?.search(text: searchText)
    }
}

extension MainSearchingViewController: MainSearchingDelegate {
    func passSearchResults(results: [String]) {
        self.results = results
        theTableView.reloadData()
    }
    
    func pass(gigs: [Gig]) {
        delegate?.pass(gigs: gigs)
        popVC()
    }
    
    func getMostCurrentSearchText() -> String? {
        return theSearchBar.text
    }
    
    func hideSpinner() {
        theSpinnerView?.removeFromSuperview()
    }
}
