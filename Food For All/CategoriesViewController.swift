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
    var glidingView: GlidingCollection!
    
    var dataStore: CategoriesDataStore?
    
    var categories: [String] = Helpers.categories
    var dictionary: [String : [Gig]] = [:]
    var hasLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reorderMilkMoooversPosition()
        createDictionaryHeaders()
        glidingCollectionViewSetup()
        dataStoreSetup()
        self.view.backgroundColor = UIColor.white
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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

extension CategoriesViewController: GlidingCollectionDatasource, UICollectionViewDataSource {
    var visibleGigs: [Gig] {
        let sectionIndex: Int = glidingView.expandedItemIndex
        let gigs = dictionary[categories[sectionIndex].lowercased()] ?? []
        return gigs
    }
    
    fileprivate func glidingCollectionViewSetup() {
        var config = GlidingConfig.shared
        config.cardsSize = CGSize(width: 200, height: GigCollectionViewCell.Constants.height)
        GlidingConfig.shared = config
        glidingView = GlidingCollection(frame: self.view.frame)
        registerCollectionCells()
        glidingView.dataSource = self
        glidingView.collectionView.dataSource = self
        glidingView.collectionView.delegate = self
        glidingView.collectionView.backgroundColor = glidingView.backgroundColor
        self.view.addSubview(glidingView)
    }
    
    fileprivate func registerCollectionCells() {
        glidingView.collectionView.register(GigCollectionViewCell.self, forCellWithReuseIdentifier: GigCollectionViewCell.identifier)
        glidingView.collectionView.register(EmptyGigsCollectionViewCell.self, forCellWithReuseIdentifier: EmptyGigsCollectionViewCell.identifier)
    }
    
    func numberOfItems(in collection: GlidingCollection) -> Int {
        return categories.count
    }
    
    func glidingCollection(_ collection: GlidingCollection, itemAtIndex index: Int) -> String {
        return "-" + categories[index]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let gigs = visibleGigs
        if shouldShowEmptyState(gigs: gigs) {
            //shwo empty state cell
            return 1
        } else {
            return gigs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gigs = visibleGigs
        
        var cell: UICollectionViewCell = UICollectionViewCell()
        if shouldShowEmptyState(gigs: gigs) {
            cell = createEmptyStateCell(collectionView: collectionView, indexPath: indexPath)
        } else {
            cell = createGigCell(collectionView: collectionView, indexPath: indexPath, gigs: gigs)
        }
        
        return cell
    }
    
    fileprivate func createGigCell(collectionView: UICollectionView, indexPath: IndexPath, gigs: [Gig]) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GigCollectionViewCell.identifier, for: indexPath) as! GigCollectionViewCell
        let gig = gigs[indexPath.row]
        cell.setContents(gig: gig)
        return cell
    }
    
    fileprivate func createEmptyStateCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyGigsCollectionViewCell.identifier, for: indexPath) as! EmptyGigsCollectionViewCell
        return cell
    }
    
    fileprivate func shouldShowEmptyState(gigs: [Gig]) -> Bool {
        return gigs.isEmpty && hasLoaded
    }
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if cell is EmptyGigsCollectionViewCell {
            CreationViewController.show(from: self)
        } else if cell is GigCollectionViewCell {
            showGigDetailVC(indexPath: indexPath)
        }
    }
    
    fileprivate func showGigDetailVC(indexPath: IndexPath) {
        let gigs = visibleGigs
        let gig = gigs[indexPath.item]
        let gigDetailVC = DetailViewController(gig: gig)
        pushVC(gigDetailVC)
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
        glidingView.collectionView.reloadData()
    }
    
    fileprivate func createDictionaryHeaders() {
        for category in categories {
            dictionary[category.lowercased()] = []
        }
    }
}
