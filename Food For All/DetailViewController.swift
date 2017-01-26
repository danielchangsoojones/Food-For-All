//
//  DetailViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/25/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var theNameLabel: UILabel!
    var theProfileImageView: CircularImageView!
    var theDescriptionLabel: UILabel!
    var theTitleLabel: UILabel!
    var thePriceLabel: UILabel!
    
    var gig: Gig!
    
    init(gig: Gig) {
        super.init(nibName: nil, bundle: nil)
        self.gig = gig
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        viewSetup()
        setContents()
        descriptionSetup()
        colorPriceLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    fileprivate func viewSetup() {
        let detailView = DetailView(frame: self.view.bounds)
        self.view = detailView
        theNameLabel = detailView.theNameLabel
        theProfileImageView = detailView.theProfileImageView
        theDescriptionLabel = detailView.theDescriptionLabel
        theTitleLabel = detailView.theTitleLabel
        thePriceLabel = detailView.thePriceLabel
        detailView.theExitButton.addTarget(self, action: #selector(exitButtonPressed(sender:)), for: .touchUpInside)
        detailView.theMessageButton.addTarget(self, action: #selector(messageButtonPressed(sender:)), for: .touchUpInside)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//set contents
extension DetailViewController {
    fileprivate func setContents() {
        theNameLabel.text = gig.creator.fullName
        if let profileFile = gig.creator.profileImage {
            theProfileImageView.add(file: profileFile)
        }
        theTitleLabel.text = gig.title
        theDescriptionLabel.text = gig.description
    }
    
    fileprivate func descriptionSetup() {
        theDescriptionLabel.numberOfLines = 0
    }
    
    fileprivate func colorPriceLabel() {
        let priceString = gig.price.toString + "$ per hour"
        let indexOfMoneySign: Int = priceString.getIndexOf("$") ?? 0
        
        let myMutableString = NSMutableAttributedString(string: priceString)
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: CustomColors.JellyTeal, range: NSRange(location: 0,length: indexOfMoneySign + 1))
        
        // set label Attribute
        //thePriceLabel.text = priceString
        thePriceLabel.attributedText = myMutableString
    }
}

//button extensions
extension DetailViewController {
    func exitButtonPressed(sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func messageButtonPressed(sender: UIButton) {
        print("messsage button was pressed")
    }
}