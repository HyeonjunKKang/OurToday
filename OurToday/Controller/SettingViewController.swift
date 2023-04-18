//
//  SettingViewController.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/15.
//

import UIKit
import PhotosUI

final class SettingViewController: UIViewController {
    
    // MARK: - Properties
    
    private let settingView = SettingView()
    
    weak var delegate: PickDateDelegate?
    weak var imagedelegate: ImagePickerDelegate?

    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()
        configureController()
    }
    
    // MARK: - Actions
    
    @objc func presentPickTheDayOfOurFirstMeetViewController(){
        let controller = PickTheDayOfOurFirstMeetViewController()
        controller.delegate = self.delegate
        present(controller, animated: true)
    }
    
    @objc func presentPickBirthDayViewController(){
        let controller = PickBirthDayViewController()
        controller.delegate = self.delegate
        present(controller, animated: true)
    }
    
    @objc func handleImagePicker(){
        print("DEBUG: show imagepicker")
        
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .any(of: [.images])
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        self.present(picker, animated: true)
    }
    
    @objc func handleBackButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    private func configureController(){
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "Left Arrow").resize(to: CGSize(width: 30, height: 30)), for: .normal)
        backButton.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    private func configureButton(){
        settingView.firstMeetSettingButton.addTarget(self, action: #selector(presentPickTheDayOfOurFirstMeetViewController), for: .touchUpInside)
        settingView.loverBirthdaySettingButton.addTarget(self, action: #selector(presentPickBirthDayViewController), for: .touchUpInside)
        settingView.mainImageSettingButton.addTarget(self, action: #selector(handleImagePicker), for: .touchUpInside)
    }

}

// MARK: - PHPickerViewControllerDelegate

extension SettingViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        let itemProvider = results.first?.itemProvider
        
        DispatchQueue.global().async {
            if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self){
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    self.imagedelegate?.imagePick(self, image: image as? UIImage ?? UIImage())
                    DispatchQueue.main.async {
                        picker.dismiss(animated: true)
                    }
                }
            }
            DispatchQueue.main.async {
                picker.dismiss(animated: true)
            }
        }
    }
}
