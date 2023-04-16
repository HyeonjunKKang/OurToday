//
//  PickBirthDayViewController.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/15.
//

import UIKit
import SnapKit

import FSCalendar

final class PickBirthDayViewController: UIViewController{
    
    // MARK: - Properties
    
    let pickTheBirthDayView = IncludeCalenderView(text: "그분의 생일이 언제인가요?")
    
    weak var delegate: PickDateDelegate?
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = pickTheBirthDayView
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
        pickTheBirthDayView.fsCalendar.delegate = self
        pickTheBirthDayView.nextButton.addTarget(self, action: #selector(checkNext), for: .touchUpInside)
    }
}

// MARK: - FSCalendarDelegate

extension PickBirthDayViewController: FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let selectedDate = date + 86400
        delegate?.pickDay(controller: self, selecteDay: selectedDate)
    }
}
