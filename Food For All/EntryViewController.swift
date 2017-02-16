//
//  EntryViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 2/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    var theStackView: UIStackView = UIStackView()
    var theSpinnerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        stackViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navController = self.navigationController as? WelcomeNavigationController {
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
    
    fileprivate func stackViewSetup() {
        theStackView.axis = .vertical
        theStackView.alignment = .fill
        theStackView.distribution = .equalCentering
        theStackView.spacing = 10
        
        //If I change the name of a button, make sure that I update the necessary tags, because it searches tags based upon their button name.
        let _ = createButton(title: "Tutoring", backgroundColor: UIColor.clear, textColor: UIColor.white)
        let _ = createButton(title: "Laundry", backgroundColor: UIColor.white, textColor: CustomColors.JellyTeal)
        let _ = createButton(title: "Haircuts", backgroundColor: UIColor.white, textColor: CustomColors.JellyTeal)
        _ = createButton(title: "Other", backgroundColor: UIColor.white, textColor: CustomColors.JellyTeal)
        self.view.addSubview(theStackView)
        theStackView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(self.view.frame.width * 0.05)
        }
    }
    
    private func createButton(title: String, backgroundColor: UIColor, textColor: UIColor) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.addBorder(width: 2, color: textColor)
        button.setTitle(title, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.layer.borderColor = textColor.cgColor
        button.backgroundColor = backgroundColor
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        theStackView.addArrangedSubview(button)
        button.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        return button
    }
    
    func buttonTapped(sender: UIButton) {
        theSpinnerView = Helpers.showActivityIndicatory(uiView: self.view)
        let dataStore = EntryDataStore(delegate: self)
        dataStore.findGigsWith(tag: sender.titleLabel?.text ?? "")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
