//
//  RecommendDateCell.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import UIKit
import SnapKit
import SDWebImage

class RecommendDateCell: UICollectionViewCell{
    
    // MARK: - Properties
    
    var viewModel: RecommendDateViewModel?{
        didSet{
            binding()
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10

        return iv
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    // MARK: - Helper
    
    func configureUI(){
        [
            imageView
        ].forEach({addSubview($0)})
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(5)
        }
    }
    
    func binding(){
        guard let url = viewModel?.imagerUrl else { return }
        viewModel?.loadImage(url: url, completion: { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        })
    }
}
