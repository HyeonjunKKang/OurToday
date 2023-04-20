//
//  RecommendDateCell.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import UIKit
import SnapKit
import JGProgressHUD
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
    
    let hud = JGProgressHUD(style: .extraLight)
    
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
        showLoader(true)
    }
    
    // MARK: - Helper
    
    func configureUI(){
        [
            imageView
        ].forEach({addSubview($0)})
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(5)
        }
    
        showLoader(true)
        
    }
    
    func binding(){
        guard let imageurl = viewModel?.imagerUrl, let url = URL(string: imageurl) else {
            return }
        imageView.sd_setImage(with: url) { [weak self] _, _, _, _ in
            self?.showLoader(false)
        }
    }
    
    func showLoader(_ show: Bool){
        if show {
            hud.show(in: contentView)
        } else {
            hud.dismiss(animated: true)
        }
    }
}
