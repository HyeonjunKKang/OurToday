//
//  PickTheDayOfOurFirstMeetViewController.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/15.
//

import UIKit
import SnapKit
import FSCalendar

final class PickTheDayOfOurFirstMeetViewController: UIViewController{
    
    // MARK: - Properties
    
    weak var delegate: PickDateDelegate?
    
    let pickTheDayView = IncludeCalenderView(text: "언제부터 사랑하셨나요?")
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = pickTheDayView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Action
    
    @objc func checkNext(){
        delegate?.dayDidComplete(controller: self)
    }
    
    // MARK: - Helper
    
    func configure(){
        pickTheDayView.fsCalendar.delegate = self
        pickTheDayView.nextButton.addTarget(self, action: #selector(checkNext), for: .touchUpInside)
    }
}

// MARK: - FSCalendarDelegate

extension PickTheDayOfOurFirstMeetViewController: FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let selectedDate = date
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let localeDate = dateFormatter.string(from: selectedDate)
        
        let newDate = dateFormatter.date(from: localeDate)
        
        delegate?.pickDay(controller: self, selecteDay: newDate ?? selectedDate)
    }
}
