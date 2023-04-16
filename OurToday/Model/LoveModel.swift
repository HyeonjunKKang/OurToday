//
//  LoveModel.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import UIKit

struct LoveModel: Codable{
    var firstLoveDay: Date?
    var loverBirthDay: Date?
    var mainImage: Data?
    var myNickname: String? = "애칭"
    var myImage: Data?
    var loverNickname: String? = "애칭"
    var loverImage: Data?
}
