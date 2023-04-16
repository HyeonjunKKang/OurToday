//
//  UserDefaultManager.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import UIKit

final class UserDefaultsManager{
    static var shared = UserDefaultsManager()
    
    
    func loadUserDefaults(completion: (LoveModel) -> ()){
        guard let data = UserDefaults.standard.value(forKey: USERDEFAULT) as? Data,
              let LoveData = try? PropertyListDecoder().decode(LoveModel.self, from: data) else {
            
            writeUserDefaults(loveModel: LoveModel())
            completion(LoveModel())
            return
        }
        completion(LoveData)
    }
    
    func writeUserDefaults(loveModel: (LoveModel)){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(loveModel), forKey: USERDEFAULT)
    }
    
}
