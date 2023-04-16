//
//  PickTheDayOfOurFIrstMeetViewModel.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import Foundation

final class PickTheDayOfOurFIrstMeetViewModel{
    
    // MARK: - Properties
    
    var loveModel: LoveModel
    
    var checkFirstLoveDay: Bool{
        guard let _ = loveModel.firstLoveDay else {
            return false
        }
        
        return true
    }
    
    var checkLoverBirthDay: Bool{
        guard let _ = loveModel.firstLoveDay else {
            return false
        }
        
        return true
    }
    
    var firstLoveDay: Date?{
        get{
            return loveModel.firstLoveDay
        }
        set{
            loveModel.firstLoveDay = newValue
        }
    }
    
    var loverBirthDay: Date?{
        get{
            return loveModel.loverBirthDay
        }
        set{
            loveModel.loverBirthDay = newValue
        }
    }
    
    // MARK: - Initializer
    
    init(){
        self.loveModel = LoveModel()
    }
    
    init(loveModel: LoveModel){
        self.loveModel = loveModel
    }
}
