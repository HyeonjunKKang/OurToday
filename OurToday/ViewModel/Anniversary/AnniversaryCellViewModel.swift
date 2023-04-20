//
//  AnniversaryCellViewModel.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/18.
//

import Foundation

struct AnniversaryCellViewModel{
    
    // MARK: - Properties
    private let anniversaryModel: AnniversaryModel
    
    var whatDay: String{
        return anniversaryModel.whatDay
    }
    
    var date: String{
        return anniversaryModel.date
    }
    
    var remainDay: String{
        return anniversaryModel.remainDay
    }
    

    
    
    // MARK: - Initializer
    init(anniversaryModel: AnniversaryModel) {
        self.anniversaryModel = anniversaryModel
    }
    
    
}
