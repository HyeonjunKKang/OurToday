//
//  AnniversaryViewController.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/15.
//

import UIKit
import SnapKit

final class AnniversaryViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var viewModel: AnniversaryViewModel
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        showLoader(true)
    }
    
    // MARK: - Initializer
    
    init(viewModel: AnniversaryViewModel, collectionviewLayout: UICollectionViewFlowLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: collectionviewLayout)
        setViewModelLoveModelDidChange()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureCollectionView(){
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "mainLogo"))
        collectionView.register(AnniversaryCell.self, forCellWithReuseIdentifier: CELL_ANNIVERSARY)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setViewModelLoveModelDidChange(){
        // 델리게이트 패턴이 아닌 클로저형식의 값, 이벤트 처리
        viewModel.loveModelDidChage = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.showLoader(false)
            }
        }
    }
    
    func bind(lovedata: LoveModel){
        self.viewModel.setLoveModel(loveModel: lovedata)
    }
}

// MARK: - UICollectionViewDataSource

extension AnniversaryViewController{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ANNIVERSARY, for: indexPath) as? AnniversaryCell else { return UICollectionViewCell()}
        cell.viewModel = AnniversaryCellViewModel(anniversaryModel: viewModel.getOnlyanniversaryList(indexPath.row))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.anniversaryListCount
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AnniversaryViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
}
