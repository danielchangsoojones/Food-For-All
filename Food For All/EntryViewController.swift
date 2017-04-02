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

class EntryViewController: UIViewController {
    var theStackView: UIStackView = UIStackView()
    var theSpinnerView: UIView?
    var theTableView: UITableView!
    
    var categories: [String] = Helpers.categories
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMilkMoooversCategory()
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
    
    func addMilkMoooversCategory() {
        categories.insert("Milk Mooovers", at: categories.count - 1)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension EntryViewController {
    fileprivate func navBarSetup() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    func searchButtonTapped() {
        let searchVC = MainSearchingViewController()
        pushVC(searchVC)
    }
}

extension EntryViewController: UITableViewDelegate, UITableViewDataSource {
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
        categoryTapped(tag: category)
    }
    
    func categoryTapped(tag: String) {
        theSpinnerView = Helpers.showActivityIndicatory(uiView: self.view)
        let dataStore = EntryDataStore(delegate: self)
        dataStore.findGigsWith(tag: tag)
    }
}

extension EntryViewController: EntryDelegate {
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

extension EntryViewController {
    static func present(from vc: UIViewController) {
        let startingVC = EntryViewController()
        vc.presentVC(startingVC)
    }
}
