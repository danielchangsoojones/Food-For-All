//
//  EntryViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    var theTableView: UITableView!
    
    var dataStore: CategoriesDataStore?
    
    var categories: [String] = Helpers.categories
    var dictionary: [String : [Gig]] = [:]
    var hasLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reorderMilkMoooversPosition()
        createDictionaryHeaders()
        viewSetup()
        dataStoreSetup()
        self.view.backgroundColor = UIColor.white
    }
    
    fileprivate func viewSetup() {
        let categoriesView = CategoriesView(frame: self.view.bounds)
        self.view = categoriesView
        theTableView = categoriesView.theTableView
        tableViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navBarSetup()
    }
    
    fileprivate func navBarSetup() {
        if let navController = navigationController as? ClearNavigationController {
            navController.change(color: CustomColors.JellyTeal)
            //Must set title of the navigationItem instead of VC or else the tab bar has the title on it.
            self.navigationItem.title = "Discover"
        }
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func tableViewSetup() {
        theTableView.delegate = self
        theTableView.dataSource = self
        theTableView.contentInset.bottom = tabBarHeight
        registerTableViewCells()
    }
    
    fileprivate func registerTableViewCells() {
        theTableView.register(DiscoverSectionHeaderTableViewCell.self, forCellReuseIdentifier: DiscoverSectionHeaderTableViewCell.identifier)
        theTableView.register(DiscoverTableViewCell.self, forCellReuseIdentifier: DiscoverTableViewCell.identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscoverTableViewCell.identifier, for: indexPath) as! DiscoverTableViewCell
        let category = categories[indexPath.section]
        let gigs: [Gig] = dictionary[category.lowercased()] ?? []
        cell.setContent(gigs: gigs, shouldShowEmptyState: shouldShowEmptyState(gigs: gigs))
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GigCollectionViewCell.Constants.height + 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: DiscoverSectionHeaderTableViewCell.identifier) as! DiscoverSectionHeaderTableViewCell
        let category = categories[section]
        let categoryCount = dictionary[category.lowercased()]?.count ?? 0
        headerView.setContent(title: categories[section], categoryCount: categoryCount)
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25
    }
    
    fileprivate func shouldShowEmptyState(gigs: [Gig]) -> Bool {
        return gigs.isEmpty && hasLoaded
    }
}

extension CategoriesViewController: DiscoverSectionHeaderDelegate {
    func showAllGigs(for category: String) {
        //TODO: this is not the most failsafe way to get the category name.
        let frontPageVC = FrontPageViewController()
        let gigs = dictionary[category.lowercased()] ?? []
        frontPageVC.gigs = gigs
        pushVC(frontPageVC)
    }
}

extension CategoriesViewController: DiscoverTableViewCellDelegate {
    func pressed(gig: Gig) {
        let gigDetailVC = DetailViewController(gig: gig)
        pushVC(gigDetailVC)
    }
    
    func emptyStatePressed() {
        CreationViewController.show(from: self)
    }
}

extension CategoriesViewController: CategoriesDataStoreDelegate {
    func loaded(gigs: [Gig]) {
        hasLoaded = true
        dictionary.removeAll()
        createDictionaryHeaders()
        for gig in gigs {
            if let category = gig.tags.first {
                dictionary[category]?.append(gig)
            }
        }
        theTableView.reloadData()
    }
    
    fileprivate func createDictionaryHeaders() {
        for category in categories {
            dictionary[category.lowercased()] = []
        }
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = CategoriesDataStore(delegate: self)
        dataStore?.loadGigs()
    }
    
    fileprivate func reorderMilkMoooversPosition() {
        if let milkIndex = categories.index(of: Helpers.milkMooovers) {
            let element = categories.remove(at: milkIndex)
            categories.insert(element, at: categories.count - 1)
        }
    }
}
