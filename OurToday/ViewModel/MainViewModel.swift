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
    
    var dateModel: [DateModel] = []
    
    var firstLoveDay: String?{
        get{
            guard let day = loveModel.firstLoveDay else { return  "0000년 00월 00일부터..."}
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy년 MM월 dd일부터.."
            return formatter.string(from: day)
        }
    }
    
    var howMany: String?{
        let calendar = Calendar.current
        guard let loveDay = loveModel.firstLoveDay else { return "우리 사랑한지 0일" }
        
        let today = Date()
        let start = calendar.startOfDay(for: loveDay)
        let end = calendar.startOfDay(for: today)
        let components = calendar.dateComponents([.day], from: start, to: end)
        return "시작한지 \(components.day ?? 0)일"
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
    
    // MARK: - Helpers
    
    func setMyImage(image: UIImage){
        if let imageData = image.pngData(){
            loveModel.myImage = imageData
        }
    }
    
    func setMainImage(image: UIImage){
        if let imageData = image.pngData(){
            loveModel.mainImage = imageData
        }
    }
    
    func setLoverImage(image: UIImage){
        if let imageData = image.pngData(){
            loveModel.loverImage = imageData
        }
    }
    
    func setMyNickname(nickName: String){
        loveModel.myNickname = nickName
    }
    
    func setLoverNickname(nickName: String){
        loveModel.loverNickname = nickName
    }
    
    func fetchData(completion: @escaping () -> ()){
        FireStoreManager.share.fetchRecommend { [weak self] models in
            self?.dateModel = models
            completion()
        }
    }
}
