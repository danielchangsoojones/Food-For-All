//
//  ProfileViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/3/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var theTableHolderView: UIView!
    var theTableView: UITableView!
    var theTableVC: UITableViewController!
    var theProfileCircleView: CircularImageView!
    var theNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        addTableVC()
        navBarSetup()
        setContent()
    }
    
    fileprivate func viewSetup() {
        let profileView = ProfileView(frame: self.view.bounds)
        self.view = profileView
        theTableHolderView = profileView.theTableHolderView
        theProfileCircleView = profileView.theProfileCircleView
        theNameLabel = profileView.theNameLabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func addTableVC() {
        let childVC = PersonalGigsTableViewController()
        childVC.delegate = self
        theTableVC = childVC
        
        let parentVC = self
        let toView = theTableHolderView
        
        if let childView = theTableVC.view {
            parentVC.addChildViewController(theTableVC)
            toView?.addSubview(childView)
            theTableVC.didMove(toParentViewController: parentVC)
            
            theTableVC.view.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        
        theTableView = theTableVC.tableView
        
        
        //FOR Testing purposes
//        let gig = Gig()
//        gig.creator = Person.current()
//        gig.title = "hi"
//        gig.price = 50
//        if let tableVC = theTableVC as? PersonalGigsTableViewController {
//            tableVC.gigs = [gig]
//        }
    }
    
    fileprivate func setContent() {
        if let profileImage = Person.current().profileImage {
            theProfileCircleView.add(file: profileImage)
        }
        theNameLabel.text = Person.current().fullName
    }
}

extension ProfileViewController: PersonalGigsTableDelegate {
    func edit(gig: Gig) {
        let rootVC = CreationViewController()
        rootVC.gig = gig
        let clearNavController = WelcomeNavigationController(rootViewController: rootVC)
        presentVC(clearNavController)
    }
}

//nav extension
extension ProfileViewController {
    fileprivate func navBarSetup() {
        leftBarButtonSetup()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Gear"), style: .plain, target: self, action: #selector(goToSettings))
    }
    
    fileprivate func leftBarButtonSetup() {
        let image = #imageLiteral(resourceName: "Pencil")
        let whiteImage = image.withColor(UIColor.white)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: whiteImage, style: .plain, target: self, action: #selector(editProfile))
    }
    
    func editProfile() {
        print("edit profile")
    }
    
    func goToSettings() {
        print("go to settings")
    }
}
