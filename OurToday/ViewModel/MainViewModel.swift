//
//  MainViewModel.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import UIKit
import RealmSwift

final class MainViewModel{
    
    // MARK: - Properties
    
    let realm = try! Realm()
    
    private var loveModel: LoveModel
    
    private var dateModel: [DateModel] = []
    
    var firstLoveDaytoString: String?{
        get{
            guard let day = loveModel.firstLoveDay else { return  "0000년 00월 00일부터..."}
            
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.current
            formatter.dateFormat = "yyyy년 MM월 dd일부터.."
            return formatter.string(from: day)
        }
    }
    
    var howMany: String?{
        let calendar = Calendar.current
        guard let loveDay = loveModel.firstLoveDay else { return "D-day +0일" }
        
        let today = Date()
        let start = calendar.startOfDay(for: loveDay)
        let end = calendar.startOfDay(for: today)
        let components = calendar.dateComponents([.day], from: start, to: end)
        return "D-day +\((components.day ?? 0) + 1) 일"
    }
    
    var firstLoveDay: Date?{
        return loveModel.firstLoveDay
    }
    
    var loverBirthDay: Date?{
        return loveModel.loverBirthDay
    }
    
    var mainImage: UIImage{
        get {
            if let imageData = loveModel.mainImage, let image = UIImage(data: imageData){
                return image
            } else {
                return #imageLiteral(resourceName: "mainImage")
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
    
    var dateModelCount: Int{
        return dateModel.count
    }
    
    var getOnlyLoveModel: LoveModel{
        return loveModel
    }
    
    // MARK: - Initializer
    
    init(loveModel: LoveModel) {
        self.loveModel = loveModel
    }
    
    // MARK: - Helpers
    
    func dateModel(index: Int) -> DateModel{
        return dateModel[index]
    }
    
    func setMyImage(image: UIImage){
        if let imageData = image.jpegData(compressionQuality: 0.3){
            try! realm.write{
                loveModel.myImage = imageData
            }
        }
    }
    
    func setMainImage(image: UIImage){
        DispatchQueue.main.async { [weak self] in
            if let imageData = image.jpegData(compressionQuality: 0.3){
                try! self?.realm.write{
                    self?.loveModel.mainImage = imageData
                }
            }
        }
        
    }
    
    func setLoverImage(image: UIImage){
        if let imageData = image.jpegData(compressionQuality: 0.3){
            try! realm.write{
                loveModel.loverImage = imageData
            }
        }
    }
    
    func setFirstLoveDay(date: Date){
        try! realm.write{
            loveModel.firstLoveDay = date
        }
    }
    
    func setLoverBirthDay(date: Date){
        try! realm.write{
            loveModel.loverBirthDay = date
        }
    }
    
    func setMyNickname(nickName: String){
        try! realm.write{
            loveModel.myNickname = nickName
        }
    }
    
    func setLoverNickname(nickName: String){
        try! realm.write{
            loveModel.loverNickname = nickName
        }
    }
    
    func fetchData(completion: @escaping () -> ()){
        FireStoreManager.share.fetchRecommend { [weak self] models in
            self?.dateModel = models.shuffled()
            completion()
        }
    }
    
    func saveLoveModel(completion: @escaping () -> ()){
        RealmManager.shared.update(loveData: loveModel){
            completion()
        }
    }
}
