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
    
    let settingView = SettingView()
    
    weak var delegate: PickDateDelegate?
    weak var imagedelegate: ImagePickerDelegate?

    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = settingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()
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
    
    // MARK: - Helpers
    
    func configureController(){
        navigationItem.leftBarButtonItem?.tintColor = PINKCOLOR
    }
    
    func configureButton(){
        settingView.firstMeetSettingButton.addTarget(self, action: #selector(presentPickTheDayOfOurFirstMeetViewController), for: .touchUpInside)
        settingView.loverBirthdaySettingButton.addTarget(self, action: #selector(presentPickBirthDayViewController), for: .touchUpInside)
        settingView.mainImageSettingButton.addTarget(self, action: #selector(handleImagePicker), for: .touchUpInside)
    }

}

// MARK: - PHPickerViewControllerDelegate

extension SettingViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self){
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                self.imagedelegate?.imagePick(self, image: image as? UIImage ?? UIImage())
            }
        }
    }
}
