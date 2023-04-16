//
//  FireStoreManager.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import UIKit
import Firebase

final class FireStoreManager{
    static var share = FireStoreManager()
    
    private init(){}
    
    func fetchRecommend(completion: @escaping ([DateModel]) -> Void){
        COLLECTION_RECOMMEND.getDocuments { snapshot, error in
            guard let document = snapshot?.documents else { return }
   
            let dates = document.map {
                DateModel(dictionary: $0.data())
            }
            completion(dates)
        }
    }
    
}
