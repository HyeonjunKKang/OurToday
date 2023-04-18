//
//  AnniversaryCell.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/18.
//

import UIKit

final class AnniversaryCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let whatDayLabel: UILabel = {
        let label = UILabel()
        label.text = "10일"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.04.24(월)"
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    private let remainDateLabel: UILabel = {
        let label = UILabel()
        label.text = "D-Day 9"
        label.font = .systemFont(ofSize: 20)
        label.textColor = PINKCOLOR
        
        return label
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = PINKCOLOR
        
        return view
    }()
    
    // MARK: - Lifecyce
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureLayout(){
        [
            whatDayLabel,
            dateLabel,
            remainDateLabel,
            divider
        ].forEach({addSubview($0)})
        
        whatDayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(whatDayLabel).offset(16)
            make.top.equalTo(whatDayLabel.snp.bottom).offset(8)
        }
        
        remainDateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(34)
            make.centerY.equalTo(whatDayLabel.snp.bottom)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.width.equalTo(frame.width * 0.95)
            make.centerX.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
}
