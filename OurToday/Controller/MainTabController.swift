//
//  MainTabController.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/15.
//

import UIKit

final class MainTabController: UITabBarController{
    
    // MARK: - Properties
    
    let loveModel: LoveModel
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
    }
    
    // MARK: - Initializer
    
    init(loveModel: LoveModel) {
        self.loveModel = loveModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    
    func configureViewController(){
        
        view.backgroundColor = .white
       
        let main = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "unselected-Home"), selectedImage: #imageLiteral(resourceName: "selected-Home"), rootViewController: MainViewController(viewModel: MainViewModel(loveModel: loveModel)))
        
        let Anniversary = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "unselected-Bulleted List"), selectedImage: #imageLiteral(resourceName: "selected-Bulleted List"), rootViewController: AnniversaryViewController())
        
        viewControllers = [main, Anniversary]
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        
        let iconSize = CGSize(width: 30, height: 30)
        
        let unselected = unselectedImage.resize(to: iconSize)
        let selected = selectedImage.resize(to: iconSize)
        
        nav.tabBarItem.image = unselected
        nav.tabBarItem.selectedImage = selected
        return nav
    }
    
}
