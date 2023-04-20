//
//  UIViewController+Extension.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/19.
//

import UIKit
import JGProgressHUD

extension UIViewController{
    static let hud = JGProgressHUD(style: .dark)
    
    func showLoader(_ show: Bool){
        view.endEditing(true)
        
        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss(animated: true)
        }
    }
}
