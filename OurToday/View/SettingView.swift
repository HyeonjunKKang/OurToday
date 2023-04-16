//
//  SettingView.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import UIKit
import SnapKit

class SettingView: UIView{
    
    // MARK: - Properties
    
    let firstMeetSettingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("우리 날짜", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitleColor(PINKCOLOR, for: .normal)

        return button
    }()
    
    let mainImageSettingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("우리 사진", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitleColor(PINKCOLOR, for: .normal)

        return button
    }()
    
    let loverBirthdaySettingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("우리 생일", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitleColor(PINKCOLOR, for: .normal)
        
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [self.firstMeetSettingButton, self.mainImageSettingButton, self.loverBirthdaySettingButton])
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureUI(){
        [
            stackView
        ].forEach({addSubview($0)})
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.height.equalTo(200)
        }
    }
}
