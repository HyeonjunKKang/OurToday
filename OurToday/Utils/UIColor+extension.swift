//
//  UIColor+extension.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/17.
//

import UIKit

extension UIColor{
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat){
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
