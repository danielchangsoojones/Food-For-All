//
//  CustomerPopUpViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 3/4/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit

protocol CustomerPopUpDelegate {
    func segueToMessage(time: String)
}

class CustomerPopUpViewController: CalendarPopUpViewController {
    var theTimeButton: UIButton!
    
    var gig: Gig!
    var delegate: CustomerPopUpDelegate?
    
    init(start: Date, end: Date, gig: Gig, delegate: CustomerPopUpDelegate) {
        super.init(start: start, end: end)
        self.delegate = delegate
        self.gig = gig
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewSetup() {
        let popUpView = CustomerPopUpView(frame: self.view.bounds)
        self.view = popUpView
        theDayLabel = popUpView.theDayLabel
        theTimeButton = popUpView.theTimeButton
        popUpView.theTimeButton.addTarget(self, action: #selector(timePressed(sender:)), for: .touchUpInside)
        popUpView.theNextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
    }
    
    override func setContent() {
        super.setContent()
        theTimeButton.setTitle(start?.timeString(in: .short), for: .normal)
    }
    
    override func choseNew(date: Date, sender: UIButton) {
        setTitleFor(button: sender, date: date)
    }
    
    func nextPressed() {
        delegate?.segueToMessage(time: self.start?.timeString(in: .short) ?? "")
        popupController?.dismiss()
    }
}
