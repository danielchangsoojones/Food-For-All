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
    
    let categories: [String] = Helpers.categories
    var dictionary: [String : [Gig]] = [:]
    var hasLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
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



//class CategoriesViewController: UIViewController {
//    struct Constants {
//        static let contactUs: String = "Have A Problem?"
//    }
//    
//    var theStackView: UIStackView = UIStackView()
//    var theSpinnerView: UIView?
//    var theTableView: UITableView!
//    
//    var categories: [String] = Helpers.categories
//    var contactHelper: ContactHelper?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addExtraCategories()
//        addGradient()
//        navBarSetup()
//        createTableView()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if let navController = self.navigationController as? ClearNavigationController {
//            navController.makeTransparent()
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func addGradient() {
//        let gradient:CAGradientLayer = CAGradientLayer()
//        gradient.frame.size = self.view.frame.size
//        gradient.colors = [CustomColors.AquamarineBlue.cgColor, CustomColors.GrannySmithGreen.cgColor]
//        gradient.startPoint = CGPoint(x: 0.4, y: 0.4)
//        gradient.endPoint = CGPoint(x: 1, y: 1)
//        self.view.layer.insertSublayer(gradient, at: 0)
//    }
//    
//    fileprivate func addExtraCategories() {
//        addContactUsCategory()
//    }
//    
//    fileprivate func addContactUsCategory() {
//        categories.append(Constants.contactUs)
//    }
//    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//}
//
//extension CategoriesViewController {
//    fileprivate func navBarSetup() {
//        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
//        navigationItem.rightBarButtonItem = searchButton
//    }
//    
//    func searchButtonTapped() {
//        let searchVC = MainSearchingViewController()
//        pushVC(searchVC)
//    }
//}
//
//extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
//    fileprivate func createTableView() {
//        theTableView = UITableView(frame: self.view.bounds)
//        theTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
//        let allCellsHeight: CGFloat = CategoryTableViewCell.cellHeight * CGFloat(categories.count)
//        if allCellsHeight <= self.view.frame.height {
//            //For centering the cells while we don't cover the whole screen, once we get enough categories, then we can get rid of this, just to keep things nice and neat
//            theTableView.contentInset = UIEdgeInsets(top: ((self.view.frame.height - allCellsHeight - tabBarHeight) / 2) - navigationBarHeight, left: 0, bottom: 0, right: 0)
//        }
//        theTableView.backgroundColor = UIColor.clear
//        theTableView.separatorStyle = .none
//        self.view.addSubview(theTableView)
//        theTableView.delegate = self
//        theTableView.dataSource = self
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return categories.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as! CategoryTableViewCell
//        let category = categories[indexPath.row]
//        cell.setButton(title: category)
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CategoryTableViewCell.cellHeight
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let category = categories[indexPath.row]
//        if category == Constants.contactUs {
//            contactCategoryTapped()
//        } else {
//            categoryTapped(tag: category)
//        }
//    }
//    
//    fileprivate func contactCategoryTapped() {
//        //TODO: implement the contact us
//        //need to hold contactHelper in global variable because it uses a message helper which needs to still be alive when the function finished because it is a long running operation to open up a message.
//        contactHelper = ContactHelper()
//        contactHelper?.contactUs(currentVC: self)
//    }
//    
//    func categoryTapped(tag: String) {
//        theSpinnerView = Helpers.showActivityIndicatory(uiView: self.view)
//        let dataStore = CategoryDataStore(delegate: self)
//        dataStore.findGigsWith(tag: tag)
//    }
//}
//
//extension CategoriesViewController: CategoriesDelegate {
//    func segueIntoApp(gigs: [Gig], vcTitle: String) {
//        let startingVC = FrontPageViewController()
//        startingVC.gigs = gigs
//        startingVC.title = vcTitle
//        removeSpinner()
//        pushVC(startingVC)
//    }
//    
//    func removeSpinner() {
//        theSpinnerView?.removeFromSuperview()
//    }
//}
//
//extension CategoriesViewController {
//    static func present(from vc: UIViewController) {
//        let startingVC = CategoriesViewController()
//        vc.presentVC(startingVC)
//    }
//}
