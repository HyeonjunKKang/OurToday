//
//  DetailInfoVIewController.swift
//  OurToday
//
//  Created by 강현준 on 2023/04/17.
//

import UIKit
import SDWebImage
import MapKit

final class DetailDeteInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: DetailDateInfoViewModel
    
    private let detailDateInfoView = DetailDateInfoView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = detailDateInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureController()
        binding()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        SDWebImageManager.shared.cancelAll()
    }
    
    // MARK: - Initializer
    
    init(viewModel: DetailDateInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
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
    
    private func binding() {
        navigationItem.title = viewModel.name
        detailDateInfoView.mainImageView.sd_setImage(with: viewModel.imageUrl)
        detailDateInfoView.addressTextLabel.text = viewModel.address
        detailDateInfoView.introduceTextLabel.text = viewModel.introduce
        
        loadMap()
    }
    
    private func loadMap(){
        let geocoder = CLGeocoder()
        let address = viewModel.address
        
        geocoder.geocodeAddressString(address) { [weak self] (placemark, error) in
            guard let self = self else { return }
            if let error = error{
                print("DEBUG: \(error.localizedDescription)")
                return
            } else {
                if let placemark = placemark?.first, let coordinate = placemark.location?.coordinate{
                    self.detailDateInfoView.mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
                    let anotation = MKPointAnnotation()
                    anotation.coordinate = coordinate
                    anotation.title = address
                    self.detailDateInfoView.mapView.addAnnotation(anotation)
                }
            }
        }
        
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.tintColor = PINKCOLOR
    }
}
