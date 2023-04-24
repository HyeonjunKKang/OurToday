//
//  AnniversaryViewModel.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/18.
//

import UIKit

final class AnniversaryViewModel{
    
    // MARK: - Properties
    
    private var loveModel: LoveModel{
        didSet{
            calculateAnniversary()
        }
    }
    
    private var anniversaryList: [AnniversaryModel] = []
    
    let service = AnniversaryService.shared
    
    var loveModelDidChage : (() -> ())?
    
    var anniversaryListCount: Int{
        return anniversaryList.count
    }
    
    // MARK: - Initializer
    
    init(loveModel: LoveModel) {
        self.loveModel = loveModel
        calculateAnniversary()
    }
    
    // MARK: - Helper
    
    func calculateAnniversary(){
        self.service.calculateAnniversary(loveModel: loveModel) { [weak self] anniversaryList in
            self?.anniversaryList = anniversaryList
            self?.loveModelDidChage?()
        }
    }
    
    func getOnlyanniversaryList(_ index: Int) -> AnniversaryModel{
        return anniversaryList[index]
    }
    
    func setLoveModel(loveModel: LoveModel){
        self.loveModel = loveModel
    }
}
