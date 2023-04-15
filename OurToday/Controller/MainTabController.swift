//
//  MainTabController.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/15.
//

import UIKit

class MainTabController: UITabBarController{
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    // MARK: - Helper
    
    func configureViewController(){
        view.backgroundColor = .white
        
        let main = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "unselected-Home"), selectedImage: #imageLiteral(resourceName: "selected-Home"), rootViewController: MainViewController())
        
        let Anniversary = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "unselected-Bulleted List"), selectedImage: #imageLiteral(resourceName: "selected-Bulleted List"), rootViewController: AnniversaryViewController())
        
        viewControllers = [main, Anniversary]
       
        
        
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController{
        let insets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0) // 이미지 위치 조절
        let nav = UINavigationController(rootViewController: rootViewController)
        
        let iconSize = CGSize(width: 30, height: 30)
        
        let unselected = unselectedImage.resize(to: iconSize)
        let selected = selectedImage.resize(to: iconSize)
        
        nav.tabBarItem.image = unselected
        nav.tabBarItem.selectedImage = selected
        return nav
    }
    
}
