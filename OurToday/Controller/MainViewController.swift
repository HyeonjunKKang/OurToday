//
//  MainViewController.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/15.
//

import UIKit
import SnapKit

class MainViewController: UIViewController{
    
    // MARK: - Properties
    
    let logoImage = #imageLiteral(resourceName: "mainLogo")
    let mainView = MainView()
    
    
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureUI()
    }
    
    // MARK: - Actions
    
    @objc func didTapSetting(){
        
    }
    
    // MARK: - Helper
    
    func configureViewController(){
        
        navigationItem.titleView = UIImageView(image: logoImage)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Gear").resize(to: CGSize(width: 24, height: 24)), style: .done, target: self, action: #selector(didTapSetting))
        
    }
    
    func configureUI(){
        
        navigationController?.navigationBar.isTranslucent = false
        

    }
}
