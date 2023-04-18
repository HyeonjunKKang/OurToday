//
//  DateModel.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/16.
//

import UIKit

struct DateModel{
    let name: String
    let introduce: String
    let address: String
    let imageurl: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.introduce = dictionary["introduce"] as? String ?? ""
        self.address = dictionary["address"] as? String ?? ""
        self.imageurl = dictionary["imageurl"] as? String ?? ""
    }
}
