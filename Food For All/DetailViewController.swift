//
//  DetailViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 1/25/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import MessageUI

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
        viewSetup()
        setContents()
        descriptionSetup()
        colorPriceLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
        sendSMSText(phoneNumber: gig.phoneNumber.toString)
    }
}

//Text messaging extension
extension DetailViewController: MFMessageComposeViewControllerDelegate {
    func sendSMSText(phoneNumber: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "We need to think of something to say to the tutor..."
            controller.recipients = [phoneNumber]
            controller.messageComposeDelegate = self
            let spinnerContainer: UIView = Helpers.showActivityIndicatory(uiView: self.view)
            self.present(controller, animated: true, completion: {
                spinnerContainer.removeFromSuperview()
            })
        } else {
            Helpers.showBanner(title: "Message Error", subtitle: "Can not send messages currently")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: {
            Helpers.showBanner(title: "Succesful Message", subtitle: "You have succesfully texted the tutor", bannerType: .success)
        })
    }
}
