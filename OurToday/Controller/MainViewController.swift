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
    
    private var viewModel: MainViewModel
    
    // MARK: - LifeCycle
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureUI()
        configureGuesture()
        configureCollectionView()
        
        fetchRecommendData()
        
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
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.mainView.firstDayLabel.text = self.viewModel.firstLoveDaytoString
            self.mainView.loveDayLabel.text = self.viewModel.howMany
            self.mainView.myNicknameLabel.text = self.viewModel.myNickName
            self.mainView.loverNicknameLabel.text = self.viewModel.loverNickName
            self.mainView.mainImageView.image = self.viewModel.mainImage
            self.mainView.myImageView.image = self.viewModel.myImage
            self.mainView.loverImageView.image = self.viewModel.loverImage
            self.mainView.myNicknameLabel.text = self.viewModel.myNickName
        }
    }
    
    func configureViewController(){
        navigationItem.titleView = UIImageView(image: logoImage)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Gear").resize(to: CGSize(width: 24, height: 24)), style: .done, target: self, action: #selector(didTapSetting))
    }
    
    func configureUI(){
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func configureCollectionView(){
        mainView.recommendCollectionView.dataSource = self
        mainView.recommendCollectionView.delegate = self
        mainView.recommendCollectionView.register(RecommendDateCell.self, forCellWithReuseIdentifier: CELL_RECOMMEND)
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
    
    func fetchRecommendData(){
        viewModel.fetchData { [weak self] in
            self?.mainView.recommendCollectionView.reloadData()
        }
    }
    
    func checkFirstMeet(){
        if viewModel.firstLoveDay == nil{
            let controller = PickTheDayOfOurFirstMeetViewController()
            controller.modalPresentationStyle = .fullScreen
            controller.delegate = self
            self.present(controller, animated: false)
        }
    }
    
    func checkLoverBirth(){
        if viewModel.loverBirthDay == nil{
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
        
        switch controller{
        case let vc as PickTheDayOfOurFirstMeetViewController:
            print("DEBUG: It's Completed select PickTheDayOfOurFIrstMeetViewController")
            viewModel.saveLoveModel {
                self.binding()
            }
            vc.dismiss(animated: true) {
                self.checkLoverBirth()
            }
            
        case let vc as PickBirthDayViewController:
            print("DEBUG: It's Completed select PickBirthDayViewController")
            
            viewModel.saveLoveModel {
                self.binding()
            }
            vc.dismiss(animated: true) {
                self.binding()
            }
            
        default:
            break
        }
    }
    
    func pickDay(controller: UIViewController, selecteDay: Date) {
        
        switch controller{
        case let _ as PickTheDayOfOurFirstMeetViewController:
            print("DEBUG: It's PickTheDayOfOurFIrstMeetViewController")
            viewModel.setFirstLoveDay(date: selecteDay)

        case let _ as PickBirthDayViewController:
            print("DEBUG: It's PickBirthDayViewController")
            viewModel.setLoverBirthDay(date: selecteDay)
            
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

extension MainViewController: PHPickerViewControllerDelegate {
    // 이미지가 완전히 load되고 dismiss해야 메모리 릭을 방지할 수 있다.
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let itemProvider = results.first?.itemProvider
        
        if let provider = itemProvider, provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                guard let self = self, let image = object as? UIImage else {
                    picker.dismiss(animated: true)
                    return
                }
                DispatchQueue.main.async {
                    if picker.view.tag == 1 {
                        self.viewModel.setMyImage(image: image)
                    }
                    if picker.view.tag == 2 {
                        self.viewModel.setLoverImage(image: image)
                    }
                    self.binding()
                    picker.dismiss(animated: true)
                }
            }
        } else {
            picker.dismiss(animated: true)
        }
    }
}


// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dateModelCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_RECOMMEND, for: indexPath) as? RecommendDateCell else { return UICollectionViewCell() }
        cell.viewModel = RecommendDateViewModel(date: viewModel.dateModel(index: indexPath.row))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = DetailDeteInfoViewController(viewModel: DetailDateInfoViewModel(dateModel: viewModel.dateModel(index: indexPath.row)))
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.bounds.height
        
        return CGSize(width: cellHeight, height: cellHeight)
    }
    
    
}

