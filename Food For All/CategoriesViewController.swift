//
//  EntryViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import Mixpanel
import GlidingCollection

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
        registerTableViewCells()
    }
    
    fileprivate func registerTableViewCells() {
        theTableView.register(DiscoverSectionHeaderTableViewCell.self, forCellReuseIdentifier: DiscoverSectionHeaderTableViewCell.identifier)
        theTableView.register(DiscoverSectionFooterTableViewCell.self, forCellReuseIdentifier: DiscoverSectionFooterTableViewCell.identifier)
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
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableCell(withIdentifier: DiscoverSectionFooterTableViewCell.identifier) as! DiscoverSectionFooterTableViewCell
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 25
    }
    
    fileprivate func shouldShowEmptyState(gigs: [Gig]) -> Bool {
        return gigs.isEmpty && hasLoaded
    }
}

//extension CategoriesViewController: GlidingCollectionDatasource, UICollectionViewDataSource {
//    var visibleGigs: [Gig] {
//        let sectionIndex: Int = glidingView.expandedItemIndex
//        let gigs = dictionary[categories[sectionIndex].lowercased()] ?? []
//        return gigs
//    }
//    
//    fileprivate func glidingCollectionViewSetup() {
//        var config = GlidingConfig.shared
//        config.cardsSize = CGSize(width: 200, height: GigCollectionViewCell.Constants.height)
//        config.animationDuration = 0
//        GlidingConfig.shared = config
//        glidingView = GlidingCollection(frame: self.view.frame)
//        registerCollectionCells()
//        glidingView.dataSource = self
//        glidingView.collectionView.dataSource = self
//        glidingView.collectionView.delegate = self
//        glidingView.collectionView.backgroundColor = glidingView.backgroundColor
//        self.view.addSubview(glidingView)
//    }
//    
//    fileprivate func registerCollectionCells() {
//        glidingView.collectionView.register(GigCollectionViewCell.self, forCellWithReuseIdentifier: GigCollectionViewCell.identifier)
//        glidingView.collectionView.register(EmptyGigsCollectionViewCell.self, forCellWithReuseIdentifier: EmptyGigsCollectionViewCell.identifier)
//    }
//    
//    func numberOfItems(in collection: GlidingCollection) -> Int {
//        return categories.count
//    }
//    
//    func glidingCollection(_ collection: GlidingCollection, itemAtIndex index: Int) -> String {
//        return "-" + categories[index]
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let gigs = visibleGigs
//        if shouldShowEmptyState(gigs: gigs) {
//            //shwo empty state cell
//            return 1
//        } else {
//            return gigs.count
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let gigs = visibleGigs
//        
//        var cell: UICollectionViewCell = UICollectionViewCell()
//        if shouldShowEmptyState(gigs: gigs) {
//            cell = createEmptyStateCell(collectionView: collectionView, indexPath: indexPath)
//        } else {
//            cell = createGigCell(collectionView: collectionView, indexPath: indexPath, gigs: gigs)
//        }
//        
//        return cell
//    }
//    
//    fileprivate func createGigCell(collectionView: UICollectionView, indexPath: IndexPath, gigs: [Gig]) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GigCollectionViewCell.identifier, for: indexPath) as! GigCollectionViewCell
//        let gig = gigs[indexPath.row]
//        cell.setContents(gig: gig)
//        return cell
//    }
//    
//    fileprivate func createEmptyStateCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyGigsCollectionViewCell.identifier, for: indexPath) as! EmptyGigsCollectionViewCell
//        return cell
//    }
//    
//    fileprivate func shouldShowEmptyState(gigs: [Gig]) -> Bool {
//        return gigs.isEmpty && hasLoaded
//    }
//}
//
//extension CategoriesViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        if cell is EmptyGigsCollectionViewCell {
//            CreationViewController.show(from: self)
//        } else if cell is GigCollectionViewCell {
//            showGigDetailVC(indexPath: indexPath)
//        }
//    }
//    
//    fileprivate func showGigDetailVC(indexPath: IndexPath) {
//        let gigs = visibleGigs
//        let gig = gigs[indexPath.item]
//        let gigDetailVC = DetailViewController(gig: gig)
//        pushVC(gigDetailVC)
//    }
//}

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
