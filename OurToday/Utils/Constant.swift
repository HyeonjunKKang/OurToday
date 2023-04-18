//
//  Constant.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/15.
//

import UIKit
import Firebase

let PINKCOLOR = UIColor(red: 253, green: 142, blue: 142)

let GRAYTEXTCOLOR = UIColor(red: 144, green: 137, blue: 137)

let USERDEFAULT = "LoveModel"

let CELL_RECOMMEND = "RecommendDateCell"

let COLLECTION_RECOMMEND = Firestore.firestore().collection("recommenddate")

let ERROR_IMAGE = #imageLiteral(resourceName: "에러이미지")
