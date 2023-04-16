//
//  MainViewController.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/15.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController{
    
    // MARK: - Properties
    
    let logoImage = #imageLiteral(resourceName: "mainLogo")
    let mainView = MainView()
    
    var viewModel: MainViewModel{
        didSet{
            binding()
        }
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(viewModel.loveModel)
        configureViewController()
        configureUI()

        checkFirstMeet()
        checkLoverBirth()
        
        binding()
    }
    
    // MARK: - Initializer
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func didTapSetting(){
        let controller = SettingViewController()
        controller.delegate = self
        controller.imagedelegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Helper
    
    func binding(){
        print("DEBUG: ViewModelBinding")
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.mainView.firstDayLabel.text = self.viewModel.firstLoveDay
            self.mainView.loveDayLabel.text = self.viewModel.howMany
            self.mainView.myNicknameLabel.text = self.viewModel.loveModel.myNickname
            self.mainView.loverNicknameLabel.text = self.viewModel.loveModel.loverNickname
            self.mainView.mainImageView.image = self.viewModel.mainImage
            self.mainView.myImageView.image = self.viewModel.myImage
            self.mainView.loverImageView.image = self.viewModel.loverImage
            self.mainView.myNicknameLabel.text = self.viewModel.myNickName
            self.mainView.loverNicknameLabel.text = self.viewModel.loverNickName
        }
    }
    
    func configureViewController(){
        navigationItem.titleView = UIImageView(image: logoImage)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Gear").resize(to: CGSize(width: 24, height: 24)), style: .done, target: self, action: #selector(didTapSetting))
        
    }
    
    func configureUI(){
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func checkFirstMeet(){
        if viewModel.loveModel.firstLoveDay == nil{
            
            let controller = PickTheDayOfOurFirstMeetViewController()
            controller.modalPresentationStyle = .fullScreen
            controller.delegate = self
            self.present(controller, animated: false)
        }
    }
    
    func checkLoverBirth(){
        if viewModel.loveModel.loverBirthDay == nil{
            
            let controller = PickBirthDayViewController()
            controller.modalPresentationStyle = .fullScreen
            controller.delegate = self
            present(controller, animated: true)
        }
    }
}

// MARK: - PickDateDelegate

extension MainViewController: PickDateDelegate{
    
    func dayDidComplete(controller: UIViewController) {
        
        binding()
        
        switch controller{
        case let vc as PickTheDayOfOurFirstMeetViewController:
            print("DEBUG: It's Completed select PickTheDayOfOurFIrstMeetViewController")
            vc.dismiss(animated: true) {
                self.checkLoverBirth()
            }
            
        case let vc as PickBirthDayViewController:
            print("DEBUG: It's Completed select PickBirthDayViewController")
            vc.dismiss(animated: true)
            
        default:
            break
        }
    }
    
    func pickDay(controller: UIViewController, selecteDay: Date) {
        
        switch controller{
        case let _ as PickTheDayOfOurFirstMeetViewController:
            print("DEBUG: It's PickTheDayOfOurFIrstMeetViewController")
            viewModel.loveModel.firstLoveDay = selecteDay

        case let _ as PickBirthDayViewController:
            print("DEBUG: It's PickBirthDayViewController")
            viewModel.loveModel.loverBirthDay = selecteDay
            
        default:
            break
        }
    }
}

// MARK: -

extension MainViewController: ImagePickerDelegate{
    func imagePick(_ controller: UIViewController, image: UIImage) {
        viewModel.mainImage = image
        binding()
    }
}

