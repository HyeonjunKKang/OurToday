//
//  MainViewModel.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import UIKit

final class MainViewModel{
    
    // MARK: - Properties
    
    var loveModel: LoveModel{
        didSet{
            UserDefaultsManager.shared.writeUserDefaults(loveModel: loveModel)
        }
    }
    
    var firstLoveDay: String?{
        get{
            guard let day = loveModel.firstLoveDay else { return  "0000년 00월 00일부터..."}
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일부터.."
            return formatter.string(from: day)
        }
    }
    
    var howMany: String?{
        let today = Date()
        guard let loveDay = loveModel.firstLoveDay else { return "우리 사랑한지 0일" }
        
        let secondBeetween = today.timeIntervalSince(loveDay)
        let daysBetween = Int(secondBeetween / 84600)
        return "우리 사랑한지 \(daysBetween)일"
    }
    
    var loverBirthDay: Date?{
        get{
            return loveModel.loverBirthDay
        }
        set{
            loveModel.loverBirthDay = newValue
        }
    }
    
    var mainImage: UIImage{
        get {
            if let imageData = loveModel.mainImage, let image = UIImage(data: imageData){
                return image
            } else {
                return #imageLiteral(resourceName: "mainImage")
            }
        }
        set{
            if let imageData = newValue.pngData(){
                loveModel.mainImage = imageData
            }
        }
    }
    
    var myImage: UIImage{
        if let imageData = loveModel.myImage, let image = UIImage(data: imageData){
            return image
        } else {
            return #imageLiteral(resourceName: "Grinning Face")
        }
    }
    
    var loverImage: UIImage{
        if let imageData = loveModel.loverImage, let image = UIImage(data: imageData){
            return image
        } else {
            return #imageLiteral(resourceName: "Grinning Face")
        }
    }
    
    var myNickName: String?{
        return loveModel.myNickname
    }
    
    var loverNickName: String?{
        return loveModel.loverNickname
    }
    
    // MARK: - Initializer
    
    init(loveModel: LoveModel) {
        self.loveModel = loveModel
    }
    
}
