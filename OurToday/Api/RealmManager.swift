//
//  RealmManager.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/18.
//

import Foundation
import RealmSwift


final class RealmManager {
    
    // Realm 데이터베이스 객체를 생성한다.
    private var realm: Realm{
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.OurToday")
        let realmURL = container?.appendingPathComponent("default.realm")
        let config = Realm.Configuration(fileURL: realmURL, schemaVersion: 1)
        return try! Realm(configuration: config)
    }

// 싱글턴 객체로, RealmManager 클래스의 인스턴스를 반환한다.
    static let shared = RealmManager()
    
    
    private init(){}

// PhotoData 객체의 배열
    var photoList = LoveModel()
    
    // MARK: - Create

    func save(_ loveModel: LoveModel) {
        // 저장할 데이터 객체 생성
        let newData = LoveModel()
        newData.id = UUID().uuidString
        newData.firstLoveDay = loveModel.firstLoveDay
        newData.loverBirthDay = loveModel.loverBirthDay
        newData.mainImage = loveModel.mainImage
        newData.myNickname = loveModel.myNickname
        newData.myImage = loveModel.myImage
        newData.loverNickname = loveModel.loverNickname
        newData.loverImage = loveModel.loverImage
        
        // Realm 데이터베이스에 데이터 저장
        try! realm.write {
            realm.add(newData)
        }
    }
    
    func getData(withId id: String) -> LoveModel? {
        // 기존 데이터 가져오기
        let existingData = realm.objects(LoveModel.self).first
        return existingData
    }
    
    
    // MARK: - Read
    
    func fetchAll() -> Results<LoveModel> {
        let results = realm.objects(LoveModel.self)
        return results
    }
    
    func fetch(byDate date: String) -> LoveModel? {
        let predicate = NSPredicate(format: "date == %@", date)
        let results = realm.objects(LoveModel.self).filter(predicate)
        return results.first
    }
    
    // MARK: - Update

    
    func update(loveData: LoveModel, completion: () -> ()) {
        // 기존 데이터 업데이트
        guard let existingData = getData(withId: loveData.id) else {
            return
        }
        do {
            try? realm.write {
                existingData.firstLoveDay = loveData.firstLoveDay
                existingData.loverBirthDay = loveData.loverBirthDay
                existingData.mainImage = loveData.mainImage
                existingData.myNickname = loveData.myNickname
                existingData.myImage = loveData.myImage
                existingData.loverNickname = loveData.loverNickname
                existingData.loverImage = loveData.loverImage
                
                completion()
            }
        } catch {
            print("DEBUG: ERROR - Realm update error \(error.localizedDescription)")
            completion()
        }

    }
    
    // MARK: - Delete
    
    func delete(loveData: LoveModel) {
        do {
            try realm.write {
                realm.delete(loveData)
            }
        } catch {
            print("Error deleting photoData: \(error)")
            
        }
    }
    
}
