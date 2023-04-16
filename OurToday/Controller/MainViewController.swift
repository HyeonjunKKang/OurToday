//
//  MainViewController.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/15.
//

import UIKit
import SnapKit
import PhotosUI

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
        
        configureViewController()
        configureUI()
        configureGuesture()

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
    
    @objc func handleMyImageTapped(){
        mainView.myPicker.delegate = self
        self.present(mainView.myPicker, animated: true)
    }
    
    @objc func handleLoverImageTapped(){
        mainView.loverPicker.delegate = self
        self.present(mainView.loverPicker, animated: true)
    }
    
    @objc func handleMyNicknameTapped(){
        print("DEBUG: 내 애칭 라벨 클릭")
        let alertController = UIAlertController(title: "나",
                                                message: "애칭을 입력해주세요",
                                                preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "입력.."
        }
        
        let okAction = UIAlertAction(title: "확인", style: .default){ _ in
            if let textFields = alertController.textFields,
               let textField = textFields.first,
               let inputText = textField.text{
                self.viewModel.setMyNickname(nickName: inputText)
                self.binding()
            }
        }
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancleAction)
        self.present(alertController, animated: true)
    }
    
    @objc func handleLoverNicknameTapped(){
        let alertController = UIAlertController(title: "상대방",
                                                message: "애칭을 입력해주세요",
                                                preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "입력.."
        }
        
        let okAction = UIAlertAction(title: "확인", style: .default){ _ in
            if let textFields = alertController.textFields,
               let textField = textFields.first,
               let inputText = textField.text{
                self.viewModel.setLoverNickname(nickName: inputText)
                self.binding()
            }
        }
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancleAction)
        self.present(alertController, animated: true)
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
    
    func configureGuesture(){
        let myImageGesture = UITapGestureRecognizer(target: self, action: #selector(handleMyImageTapped))
        mainView.myImageView.addGestureRecognizer(myImageGesture)
        mainView.myImageView.isUserInteractionEnabled = true
        
        let loverImageGesture = UITapGestureRecognizer(target: self, action: #selector(handleLoverImageTapped))
        mainView.loverImageView.addGestureRecognizer(loverImageGesture)
        mainView.loverImageView.isUserInteractionEnabled = true
        
        let myNicknameGuesture = UITapGestureRecognizer(target: self, action: #selector(handleMyNicknameTapped))
        mainView.myNicknameLabel.addGestureRecognizer(myNicknameGuesture)
        mainView.myNicknameLabel.isUserInteractionEnabled = true
        
        let loverNicknameGuesture = UITapGestureRecognizer(target: self, action: #selector(handleLoverNicknameTapped))
        mainView.loverNicknameLabel.addGestureRecognizer(loverNicknameGuesture)
        mainView.loverNicknameLabel.isUserInteractionEnabled = true
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

// MARK: - ImagePickerDelegate

extension MainViewController: ImagePickerDelegate{
    func imagePick(_ controller: UIViewController, image: UIImage) {
        viewModel.setMainImage(image: image)
        binding()
    }
}

// MARK: - PHPickerViewControllerDelegate

extension MainViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self){
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    print("DEBUG: \(picker.view.tag)")
                    if picker.view.tag == 1{
                        self.viewModel.setMyImage(image: image as? UIImage ?? UIImage())
                    }
                    if picker.view.tag == 2{
                        self.viewModel.setLoverImage(image: image as? UIImage ?? UIImage())
                    }
                    self.binding()
                }
            }
        }
    }
}

