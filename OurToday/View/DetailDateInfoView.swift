//
//  DetailDateInfoView.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/17.
//

import UIKit
import MapKit
import SnapKit

final class DetailDateInfoView: UIView{
    
    // MARK: - Properties
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    let mainImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleToFill
        imageview.image = #imageLiteral(resourceName: "sampleImage")
        
        return imageview
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "위치"
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    let addressTextLabel: UILabel = {
        let label = UILabel()
        label.text = "서울특별시 중구 을지로 281"
        label.textColor = GRAYTEXTCOLOR
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    private let introduceLabel: UILabel = {
        let label = UILabel()
        label.text = "설명"
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    let introduceTextLabel: UILabel = {
        let label = UILabel()
        label.text = "동대문 DDP는 동대문 디자인 플라자(Dongdaemun Design Plaza)의 약자이기도 하지만 꿈꾸고(Dream), 만들고(Design), 누리는(Play) 공간이 되길 바라는 뜻에서 지은 이름이라고도 해요. 그만큼 다양한전시와 먹거리, 놀 거리가 가득해 지루할 틈이 없어요. 낮에는 물론 정기 야시장이 열리기도 해서 저녁데이트 코스로도 훌륭해요."
        label.textColor = GRAYTEXTCOLOR
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        return label
    }()
    
    let mapLabel: UILabel = {
        let label = UILabel()
        label.text = "지도"
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        
        return mapView
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureLayout(){
        
        backgroundColor = .white

        self.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
        
        [
            mainImageView,
            addressLabel,
            addressTextLabel,
            introduceLabel,
            introduceTextLabel,
            mapLabel,
            mapView
            
        ].forEach( { scrollView.addSubview($0) } )
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(scrollView)
            make.height.equalTo(250)
        }
        
        let leadingOffset = 18
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(leadingOffset)
        }
        
        addressTextLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(7)
            make.leading.equalTo(addressLabel)
        }
        
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(addressTextLabel.snp.bottom).offset(20)
            make.leading.equalTo(addressLabel)
        }
        
        introduceTextLabel.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(7)
            make.leading.equalTo(addressLabel)
            make.width.equalTo(mainImageView.snp.width).inset(leadingOffset)
        }
        
        mapLabel.snp.makeConstraints { make in
            make.top.equalTo(introduceTextLabel.snp.bottom).offset(20)
            make.leading.equalTo(addressLabel)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(mapLabel.snp.bottom).offset(7)
            make.centerX.equalToSuperview()
            make.width.equalTo(330)
            make.height.equalTo(200)
        }
        
        let view = UIView()
        scrollView.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom)
            make.leading.equalTo(addressLabel)
            make.height.equalTo(200)
            make.bottom.equalToSuperview()
        }
    }
    
}
