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
        label.font = .systemFont(ofSize: 32)
        
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
    
    // MARK: - Lifecycle
    
    init(text: String){
        self.text = text
        super.init(frame: CGRect.zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureUI(){
        
        backgroundColor = .white
        
        [
            textLabel,
            fsCalendar,
            nextButton
            
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
    }
    
    
}
