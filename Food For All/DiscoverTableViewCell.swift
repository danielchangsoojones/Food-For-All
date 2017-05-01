//
//  DiscoverTableViewCell.swift
//  Food For All
//
//  Created by Daniel Jones on 5/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: HorizontalTableViewCell {
    override var reuseIdentifier: String? {
        return DiscoverTableViewCell.identifier
    }
    
    var gigs: [Gig] = []
    var shouldShowEmptyState = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(gigs: [Gig], shouldShowEmptyState: Bool) {
        self.gigs = gigs
        self.shouldShowEmptyState = shouldShowEmptyState
        //reloading a single section gives a nice animation, and I only have 1 anyway
        theCollectionView.reloadSections(IndexSet(integer: 0))
    }
}

extension DiscoverTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    fileprivate func collectionViewSetup() {
        if let flowLayout = theCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 30
            flowLayout.itemSize = CGSize(width: GigCollectionViewCell.Constants.width, height: GigCollectionViewCell.Constants.height)
        }
        theCollectionView.delegate = self
        theCollectionView.dataSource = self
        registerCollectionCells()
    }
    
    fileprivate func registerCollectionCells() {
        theCollectionView.register(GigCollectionViewCell.self, forCellWithReuseIdentifier: GigCollectionViewCell.identifier)
        theCollectionView.register(EmptyGigsCollectionViewCell.self, forCellWithReuseIdentifier: EmptyGigsCollectionViewCell.identifier)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if shouldShowEmptyState {
            //shwo empty state cell
            return 1
        } else {
            return gigs.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        if shouldShowEmptyState {
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
}

extension DiscoverTableViewCell {
    static let identifier = "discoverTableCell"
}
