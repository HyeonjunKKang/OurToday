//
//  LoveModel.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import UIKit
import RealmSwift

final class LoveModel: Object{
    @objc dynamic var id = ""
    @objc dynamic var firstLoveDay: Date?
    @objc dynamic var loverBirthDay: Date?
    @objc dynamic var mainImage: Data?
    @objc dynamic var myNickname: String? = "애칭"
    @objc dynamic var myImage: Data?
    @objc dynamic var loverNickname: String? = "애칭"
    @objc dynamic var loverImage: Data?
    
    static override func primaryKey() -> String? {
        return "id"
    }
}
