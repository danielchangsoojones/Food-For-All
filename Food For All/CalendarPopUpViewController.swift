//
//  CalendarPopUpViewController.swift
//  Food For All
//
//  Created by Daniel Jones on 3/2/17.
//  Copyright © 2017 Chong500Productions. All rights reserved.
//

import UIKit
import STPopup
import EZSwiftExtensions

protocol CalendarPopUpDelegate {
    func deleteEvent()
}

class CalendarPopUpViewController: UIViewController {
    var theDayLabel: UILabel!
    var theStartTimeButton: UIButton!
    var theEndTimeButton: UIButton!
    
    var start: Date?
    var end: Date?
    
    var delegate: CalendarPopUpDelegate?
    
    init(start: Date, end: Date, delegate: CalendarPopUpDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.start = start
        self.end = end
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        setContent()
        deleteButtonSetup()
        self.contentSizeInPopup = CGSize(width: ez.screenWidth, height: ez.screenHeight * 0.25)
    }
    
    fileprivate func viewSetup() {
        let calendarView = CalendarPopUpView(frame: self.view.bounds)
        self.view = calendarView
        theDayLabel = calendarView.theDayLabel
        theStartTimeButton = calendarView.theStartTimeButton
        theEndTimeButton = calendarView.theEndTimeButton
        calendarView.theStartTimeButton.addTarget(self, action: #selector(timePressed(sender:)), for: .touchUpInside)
        calendarView.theEndTimeButton.addTarget(self, action: #selector(timePressed(sender:)), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func deleteButtonSetup() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteEvent))
    }
    
    func deleteEvent() {
        delegate?.deleteEvent()
        self.popupController?.dismiss()
    }
    
    func timePressed(sender: UIButton) {
        
    }
}

//time extension
extension CalendarPopUpViewController {
    fileprivate func setContent() {
        theDayLabel.text = start?.toString(format: "EEE, MMM d")
        theStartTimeButton.setTitle(start?.timeString(in: .short), for: .normal)
        theEndTimeButton.setTitle(end?.timeString(in: .short), for: .normal)
    }
}
