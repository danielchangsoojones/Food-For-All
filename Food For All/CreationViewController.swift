//
//  CreationViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/1/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    var theTableView: UITableView!
    var theCameraImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        navBarSetup()
    }
    
    fileprivate func viewSetup() {
        let creationView = CreationView(frame: self.view.bounds)
        self.view = creationView
        theTableView = creationView.theTableView
        theTableView.delegate = self
        theTableView.dataSource = self
        theCameraImageView = creationView.theCameraImageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

//nav controller
extension CreationViewController {
    fileprivate func navBarSetup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(exitTapped))
    }
    
    func exitTapped() {
        self.navigationController?.dismissVC(completion: nil)
    }
}

extension CreationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.brown
        return cell
    }
}

