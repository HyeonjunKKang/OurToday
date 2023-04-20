//
//  MainView.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/15.
//

import UIKit
import SnapKit
import PhotosUI

class MainView: UIView{
    
    // MARK: - Properties
    
    let mainImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        
        return imageview
    }()
    
    let loveDayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 149/255, green: 126/255, blue: 126/255, alpha: 100)
        label.font = .systemFont(ofSize: 24)
        
        return label
    }()
    
    let myImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.image = #imageLiteral(resourceName: "Grinning Face")
        
        return imageview
    }()
    
    let heartImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.image = #imageLiteral(resourceName: "Heart")
        
        return imageview
    }()
    
    let loverImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.image = #imageLiteral(resourceName: "Grinning Face")
        
        return imageview
    }()
    
    let myNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "애칭"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    let loverNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "애칭"
        label.font = .systemFont(ofSize: 20)
        
        return label
    }()
    
    let firstDayLabel: UILabel = {
        let label = UILabel()
        label.text = "0000년 00월 00일부터.."
        label.font = .systemFont(ofSize: 16)
        label.textColor = PINKCOLOR
        
        return label
    }()
    
    private let divider = UIView()
    
    private let recommendLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 추천 데이트"
        label.textColor = UIColor(red: 149/255, green: 126/255, blue: 126/255, alpha: 100)
        label.font = .systemFont(ofSize: 24)
        
        return label
    }()
    
    let recommendCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        
        return cv
    }()
    
    let configuration: PHPickerConfiguration = {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .any(of: [.images])
        
        return config
    }()
    
    lazy var myPicker: PHPickerViewController = {
        let picker = PHPickerViewController(configuration: self.configuration)
        picker.view.tag = 1
        
        return picker
    }()
    
    lazy var loverPicker: PHPickerViewController = {
        let picker = PHPickerViewController(configuration: self.configuration)
        picker.view.tag = 2
        
        return picker
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureUI(){
        backgroundColor = .white
        
        [
            mainImageView,
            loveDayLabel,
            heartImageView,
            myImageView,
            loverImageView,
            myNicknameLabel,
            loverNicknameLabel,
            firstDayLabel,
            divider,
            recommendLabel,
            recommendCollectionView
            
        ].forEach{ addSubview($0)}
        
        mainImageView.snp.makeConstraints{ make in
            make.top.equalTo(safeAreaLayoutGuide).offset(0)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(230)
        }
        
        loveDayLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(30)
        }
        
        heartImageView.snp.makeConstraints { make in
            make.top.equalTo(loveDayLabel.snp.bottom).offset(10)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.width.equalTo(73)
        }
        
        myImageView.snp.makeConstraints { make in
            make.centerY.equalTo(heartImageView)
            make.trailing.equalTo(heartImageView.snp.leading).inset(-38)
            make.height.width.equalTo(95)

        }
        myImageView.layer.cornerRadius = 95/2
        myImageView.clipsToBounds = true
        
        loverImageView.snp.makeConstraints { make in
            make.centerY.equalTo(heartImageView)
            make.leading.equalTo(heartImageView.snp.trailing).offset(38)
            make.height.width.equalTo(95)
        }
        loverImageView.layer.cornerRadius = 95/2
        loverImageView.clipsToBounds = true
        
        myNicknameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(myImageView)
            make.top.equalTo(myImageView.snp.bottom)
        }
        
        loverNicknameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(loverImageView)
            make.top.equalTo(myImageView.snp.bottom)
        }
        
        firstDayLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(heartImageView.snp.bottom).offset(30)
        }
        
        
        divider.backgroundColor = PINKCOLOR
        divider.snp.makeConstraints { make in
            make.top.equalTo(firstDayLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(0.5)
        }
        
        recommendLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(5)
            make.leading.equalTo(loveDayLabel)
            make.trailing.equalTo(loveDayLabel)
        }
        
        recommendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendLabel.snp.bottom).offset(2)
            make.leading.equalTo(loveDayLabel)
            make.trailing.equalTo(loveDayLabel.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
    }
}
