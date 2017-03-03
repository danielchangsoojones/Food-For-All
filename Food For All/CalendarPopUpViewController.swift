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
import ActionSheetPicker_3_0

protocol CalendarPopUpDelegate {
    func deleteEvent()
    func updateTime(start: Date?, end: Date?)
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
    
    
}

//time extension
extension CalendarPopUpViewController {
    fileprivate func setContent() {
        theDayLabel.text = start?.toString(format: "EEE, MMM d")
        setTitleFor(button: theStartTimeButton, date: start)
        setTitleFor(button: theEndTimeButton, date: end)
    }
    
    func timePressed(sender: UIButton) {
        let datePicker = ActionSheetDatePicker(title: "Time", datePickerMode: .time, selectedDate: start, doneBlock: {
            picker, value, index in
            if let date = value as? Date {
                if sender == self.theStartTimeButton {
                    self.picked(newStart: date)
                } else if sender == self.theEndTimeButton {
                    self.picked(newEnd: date)
                }
                self.delegate?.updateTime(start: self.start, end: self.end)
            }
        }, cancel: {_ in
            return
        }, origin: sender)
        datePicker?.minuteInterval = 20
        datePicker?.show()
    }
    
    fileprivate func picked(newStart: Date) {
        start = newStart
        setTitleFor(button: theStartTimeButton, date: newStart)
    }
    
    func picked(newEnd: Date) {
        end = newEnd
        setTitleFor(button: theEndTimeButton, date: newEnd)
    }
    
    fileprivate func setTitleFor(button: UIButton, date: Date?) {
        button.setTitle(date?.timeString(in: .short), for: .normal)
    }
}
