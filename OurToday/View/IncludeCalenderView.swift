//
//  IncludeCalenderView.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/15.
//

import UIKit
import SnapKit
import FSCalendar

final class IncludeCalenderView: UIView{
    
    // MARK: - Properties
    
    private let text: String
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = text
        label.textColor = PINKCOLOR
        label.font = .systemFont(ofSize: 28)
        
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "Right Chevron").resize(to: CGSize(width: 50, height: 50)), for: .normal)
        
        return button
    }()
    
    let fsCalendar: FSCalendar = {
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        calendar.appearance.headerTitleColor = PINKCOLOR
        calendar.appearance.weekdayTextColor = PINKCOLOR
        calendar.appearance.selectionColor = PINKCOLOR
        
        return calendar
    }()
    
    lazy var prevYearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("< Year", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(PINKCOLOR, for: .normal)
        button.addTarget(self, action: #selector(didTapPrevYearButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var nextYearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Year >", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.setTitleColor(PINKCOLOR, for: .normal)
        button.addTarget(self, action: #selector(didTapNextYearButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(text: String){
        self.text = text
        super.init(frame: CGRect.zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    
    @objc func didTapPrevYearButton(){
        let currentYear = fsCalendar.currentPage
        guard let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: currentYear) else { return }
        fsCalendar.setCurrentPage(oneYearAgo, animated: true)
    }
    
    @objc func didTapNextYearButton(){
        let currentYear = fsCalendar.currentPage
        guard let oneYearAfter = Calendar.current.date(byAdding: .year, value: 1, to: currentYear) else { return }
        fsCalendar.setCurrentPage(oneYearAfter, animated: true)
    }
    
    // MARK: - Helper
    
    func configureUI(){
        
        backgroundColor = .white
        
        [
            textLabel,
            fsCalendar,
            nextButton,
            prevYearButton,
            nextYearButton
            
        ].forEach({addSubview($0)})
        
        textLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-200)
        }
        
        fsCalendar.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(10)
            make.height.equalTo(300)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
        
        prevYearButton.snp.makeConstraints { make in
            make.top.equalTo(fsCalendar.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
        }
        
        nextYearButton.snp.makeConstraints { make in
            make.top.equalTo(fsCalendar.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
