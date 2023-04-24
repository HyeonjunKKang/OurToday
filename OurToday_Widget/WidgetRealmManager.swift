//
//  WidgetRealmManager.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/20.
//

import UIKit
import RealmSwift

final class WidgetRealmManager{
    
    static let shared: WidgetRealmManager = .init()
    
    private init(){}
    
    private var localRealm: Realm {
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.OurToday")
        let realmURL = container?.appendingPathComponent("default.realm")
        let config = Realm.Configuration(fileURL: realmURL, schemaVersion: 1)
        return try! Realm(configuration: config)
    }
    
    func fetch() -> LoveModel {
        guard let data = localRealm.objects(LoveModel.self).first else {
            return LoveModel()
        }
        return data
    }
    
    func getMainBackgroundImage() -> UIImage{
        guard let data = localRealm.objects(LoveModel.self).first,
              let imageData = data.mainImage else {
            return #imageLiteral(resourceName: "mainImage")
        }
        let image = UIImage(data: imageData)
        let size = CGSize(width: 364, height: 180)
        if let resizedImage = image?.resize(to: size){
            return resizedImage
        }
        return #imageLiteral(resourceName: "mainImage")
    }
}
