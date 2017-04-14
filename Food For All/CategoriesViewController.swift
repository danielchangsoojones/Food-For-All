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

class CategoriesViewController: UIViewController {
    struct Constants {
        static let contactUs: String = "Have A Problem?"
    }
    
    var theStackView: UIStackView = UIStackView()
    var theSpinnerView: UIView?
    var theTableView: UITableView!
    
    var categories: [String] = Helpers.categories
    var contactHelper: ContactHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addExtraCategories()
        addGradient()
        navBarSetup()
        createTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navController = self.navigationController as? ClearNavigationController {
            navController.makeTransparent()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addGradient() {
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame.size = self.view.frame.size
        gradient.colors = [CustomColors.AquamarineBlue.cgColor, CustomColors.GrannySmithGreen.cgColor]
        gradient.startPoint = CGPoint(x: 0.4, y: 0.4)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    fileprivate func addExtraCategories() {
        addContactUsCategory()
    }
    
    fileprivate func addContactUsCategory() {
        categories.append(Constants.contactUs)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension CategoriesViewController {
    fileprivate func navBarSetup() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    func searchButtonTapped() {
        let searchVC = MainSearchingViewController()
        pushVC(searchVC)
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    fileprivate func createTableView() {
        theTableView = UITableView(frame: self.view.bounds)
        theTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        let allCellsHeight: CGFloat = CategoryTableViewCell.cellHeight * CGFloat(categories.count)
        if allCellsHeight <= self.view.frame.height {
            //For centering the cells while we don't cover the whole screen, once we get enough categories, then we can get rid of this, just to keep things nice and neat
            theTableView.contentInset = UIEdgeInsets(top: ((self.view.frame.height - allCellsHeight - tabBarHeight) / 2) - navigationBarHeight, left: 0, bottom: 0, right: 0)
        }
        theTableView.backgroundColor = UIColor.clear
        theTableView.separatorStyle = .none
        self.view.addSubview(theTableView)
        theTableView.delegate = self
        theTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as! CategoryTableViewCell
        let category = categories[indexPath.row]
        cell.setButton(title: category)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CategoryTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        if category == Constants.contactUs {
            contactCategoryTapped()
        } else {
            categoryTapped(tag: category)
        }
    }
    
    fileprivate func contactCategoryTapped() {
        //TODO: implement the contact us
        //need to hold contactHelper in global variable because it uses a message helper which needs to still be alive when the function finished because it is a long running operation to open up a message.
        contactHelper = ContactHelper()
        contactHelper?.contactUs(currentVC: self)
    }
    
    func categoryTapped(tag: String) {
        theSpinnerView = Helpers.showActivityIndicatory(uiView: self.view)
        let dataStore = CategoryDataStore(delegate: self)
        dataStore.findGigsWith(tag: tag)
    }
}

extension CategoriesViewController: CategoriesDelegate {
    func segueIntoApp(gigs: [Gig], vcTitle: String) {
        let startingVC = FrontPageViewController()
        startingVC.gigs = gigs
        startingVC.title = vcTitle
        removeSpinner()
        pushVC(startingVC)
    }
    
    func removeSpinner() {
        theSpinnerView?.removeFromSuperview()
    }
}

extension CategoriesViewController {
    static func present(from vc: UIViewController) {
        let startingVC = CategoriesViewController()
        vc.presentVC(startingVC)
    }
}
