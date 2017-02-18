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
    var theSpinnerContainer: UIView?
    var theReviewCell: UIView!
    var theTableView: UITableView!
    
    var gig: Gig!
    var dataStore: DetailDataStore!
    var cellTypes: [GigItemType] = GigItemType.mandatory
    var mutualFriends: [MutualFriend] = []
    var totalMutualFriends: Int = 0
    
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
        dataStoreSetup()
        setContents()
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
        thePriceLabel = detailView.thePriceLabel
        detailView.theExitButton.addTarget(self, action: #selector(exitButtonPressed(sender:)), for: .touchUpInside)
        detailView.theMessageButton.addTarget(self, action: #selector(messageButtonPressed(sender:)), for: .touchUpInside)
        theTableView = detailView.theTableView
        theTableView.delegate = self
        theTableView.dataSource = self
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func dataStoreSetup() {
        dataStore = DetailDataStore()
        dataStore.delegate = self
        dataStore.getMutualFriends(creator: gig.creator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentRow = indexPath.row
        let type = cellTypes[currentRow]
        let data = GigDetailData(type: type)
        var cell: UITableViewCell = UITableViewCell()
        switch type {
        case .information:
            cell = data.createInformationCell(gig: gig)
        case .review:
            cell = data.createReviewCell(gig: gig)
        case .mutualFriends:
            let friendCell = data.createMutualFriendsCell(numOfFriends: totalMutualFriends)
            friendCell.mutualFriends = self.mutualFriends
            cell = friendCell
        case .venmo:
            cell = data.createVenmoCell()
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentRow = indexPath.row
        let type = cellTypes[currentRow]
        return GigDetailData(type: type).cellHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = cellTypes[indexPath.row]
        switch type {
        case .review:
            reviewCellTapped()
        case .venmo:
            venmoTapped()
        default:
            break
        }
    }
}

//set contents
extension DetailViewController {
    fileprivate func setContents() {
        theNameLabel.text = gig.creator.fullName
        if let profileFile = gig.frontImage {
            theProfileImageView.add(file: profileFile)
        }
    }
    
    fileprivate func colorPriceLabel() {
        let priceString = gig.priceString
        let indexOfMoneySign: Int = priceString.getIndexOf("$") ?? 0
        
        let myMutableString = NSMutableAttributedString(string: priceString)
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: CustomColors.JellyTeal, range: NSRange(location: 0,length: indexOfMoneySign + 1))
        
        thePriceLabel.attributedText = myMutableString
    }
}

//button extensions
extension DetailViewController {
    func exitButtonPressed(sender: UIButton) {
        popVC()
    }
    
    func messageButtonPressed(sender: UIButton) {
        theSpinnerContainer = Helpers.showActivityIndicatory(uiView: self.view)
        sendSMSText(phoneNumber: gig.phoneNumberString)
    }
    
    func venmoTapped() {
        let venmoUsername: String? = gig.creator.venmoUsername
        let headURL = "https://venmo.com/"
        
        var venmoState: String = "pressed, but no venmo account attatched"
        if let venmoUsername = venmoUsername {
            if let destinationURL = URL(string: headURL + venmoUsername) {
                UIApplication.shared.openURL(destinationURL)
            } else {
                Helpers.showBanner(title: "Error", subtitle: "Venmo could not be loaded", bannerType: .error)
            }
            venmoState = "success"
        } else {
            //the gig creator never made a username
            Helpers.showBanner(title: "Error", subtitle: "The freelancer has not configured their venmo account yet", bannerType: .error)
        }
        
        dataStore.saveVenmoMetric(state: venmoState, gig: gig)
    }
    
    func reviewCellTapped() {
        let allReviewsVC = AllReviewsViewController(gig: gig)
        allReviewsVC.gig = gig
        pushVC(allReviewsVC)
    }
}

extension DetailViewController: DetailDataStoreDelegate {
    func received(mutualFriends: [MutualFriend], totalCount: Int) {
        if !mutualFriends.isEmpty {
            self.mutualFriends = mutualFriends
            self.totalMutualFriends = totalCount
            cellTypes = GigItemType.insertInto(array: cellTypes, type: .mutualFriends) //display the mutual friends cell, since they have them.
            theTableView.reloadData()
        }
    }
}

//Text messaging extension
extension DetailViewController: MFMessageComposeViewControllerDelegate {
    func sendSMSText(phoneNumber: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            
            var firstName: String = gig.creator.firstName ?? ""
            if firstName.isNotEmpty {
                firstName = " " + firstName
            }
            controller.body = "Hey\(firstName), I found you on Gigio for \(gig.title). Can we arrange something?"
            controller.recipients = [phoneNumber]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: {
                self.theSpinnerContainer?.removeFromSuperview()
            })
        } else {
            theSpinnerContainer?.removeFromSuperview()
            Helpers.showBanner(title: "Message Error", subtitle: "Can not send messages currently")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        var messageState: String = "defualt"
        
        switch result {
        case .cancelled:
            messageState = "clicked, but then cancelled"
        case .failed:
            messageState = "failure to send"
        case .sent:
            messageState = "successfully sent"
        }
        
        dataStore.saveMessageMetric(messageState: messageState, gig: gig)
        
        self.dismiss(animated: true, completion: {
            Helpers.showBanner(title: "Succesful Message", subtitle: "You have succesfully texted the tutor", bannerType: .success)
        })
    }
}
