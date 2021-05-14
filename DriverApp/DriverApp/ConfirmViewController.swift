//
//  ConfirmViewController.swift
//  DriverApp
//
//  Created by Michael Winailan on 5/11/21.
//

import UIKit

class ConfirmViewController: UIViewController {
    let cityNameLabel = UILabel()
    let insuranceImageView = UIImageView()
    var viewModel: ConfirmViewModel! {
        didSet {
            self.cityNameLabel.text = viewModel.driver.city
            self.insuranceImageView.image = viewModel.driver.insuranceImage
        }
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view!.backgroundColor = UIColor(named: "BackgroundColor")
        
        let cityField = HighlightView()
        let cityTap = UITapGestureRecognizer(target: self, action: #selector(self.cityFieldTapped))
        cityField.addGestureRecognizer(cityTap)
        cityField.backgroundColor = UIColor(named: "FieldBackgroundColor")
        cityField.layer.cornerRadius = 10
        cityField.layer.borderWidth = 1
        cityField.layer.borderColor = UIColor(named: "FieldBorderColor")?.cgColor
        self.view!.addSubview(cityField)
        cityField.translatesAutoresizingMaskIntoConstraints = false
        cityField.widthAnchor.constraint(equalToConstant: 326).isActive = true
        cityField.heightAnchor.constraint(equalToConstant: 58).isActive = true
        cityField.leadingAnchor.constraint(equalTo: self.view!.leadingAnchor, constant: 24).isActive = true
        cityField.topAnchor.constraint(equalTo: self.view!.topAnchor, constant: 110).isActive = true

        
        let cityTitleLabel = UILabel()
        cityTitleLabel.textColor = UIColor(named: "FieldBorderColor")
        cityTitleLabel.font = UIFont(name: "Gilroy-Light", size: 12)
        cityTitleLabel.numberOfLines = 1
        cityTitleLabel.text = "City"

        
        self.cityNameLabel.textColor = UIColor.black
        self.cityNameLabel.font = UIFont(name: "Gilroy-Light", size: 12)
        self.cityNameLabel.numberOfLines = 1
        self.cityNameLabel.lineBreakMode = .byTruncatingTail
        
        
        let stackView:UIStackView = UIStackView(arrangedSubviews: [cityTitleLabel, cityNameLabel])
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.axis = .vertical
        cityField.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: cityField.leadingAnchor, constant: 17).isActive = true
        stackView.centerYAnchor.constraint(equalTo: cityField.centerYAnchor).isActive = true
        
        
        let insuranceView = HighlightView()
        let insuranceTap = UITapGestureRecognizer(target: self, action: #selector(self.insuranceViewTapped))
        insuranceView.addGestureRecognizer(insuranceTap)
        insuranceView.backgroundColor = UIColor(named: "FieldBorderColor")
        insuranceView.layer.cornerRadius = 10
        insuranceView.layer.masksToBounds = true
        self.view!.addSubview(insuranceView)
        insuranceView.translatesAutoresizingMaskIntoConstraints = false
        insuranceView.widthAnchor.constraint(equalToConstant: 318).isActive = true
        insuranceView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        insuranceView.leadingAnchor.constraint(equalTo: self.view!.leadingAnchor, constant: 28).isActive = true
        insuranceView.topAnchor.constraint(equalTo: self.view!.topAnchor, constant: 212).isActive = true
        
        
        insuranceView.addSubview(insuranceImageView)
        self.insuranceImageView.translatesAutoresizingMaskIntoConstraints = false
        self.insuranceImageView.leadingAnchor.constraint(equalTo: insuranceView.leadingAnchor, constant: 0).isActive = true
        self.insuranceImageView.trailingAnchor.constraint(equalTo: insuranceView.trailingAnchor, constant: 0).isActive = true
        self.insuranceImageView.topAnchor.constraint(equalTo: insuranceView.topAnchor, constant: 0).isActive = true
        self.insuranceImageView.bottomAnchor.constraint(equalTo: insuranceView.bottomAnchor, constant: 0).isActive = true
        
        
        let uploadButton = UIButton(type: .system)
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        uploadButton.backgroundColor = UIColor(named: "ButtonBackgroundColor")
        uploadButton.layer.cornerRadius = 30
        uploadButton.setTitle("Upload", for: .normal)
        uploadButton.setTitleColor(UIColor.white, for: .normal)
        uploadButton.titleLabel?.font = UIFont(name: "Gilroy-ExtraBold", size: 14)
        self.view!.addSubview(uploadButton)
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.widthAnchor.constraint(equalToConstant: 288).isActive = true
        uploadButton.heightAnchor.constraint(equalToConstant: 57).isActive = true
        uploadButton.leadingAnchor.constraint(equalTo: self.view!.leadingAnchor, constant: 39).isActive = true
        uploadButton.bottomAnchor.constraint(equalTo: self.view!.bottomAnchor, constant: -61).isActive = true
        
    }
    
    // MARK: - Action Functions
    @objc func cityFieldTapped(sender: HighlightView!) {
        let cityVC = CityViewController()
        cityVC.viewModel = CityViewModel(driver: self.viewModel.driver)
        cityVC.modalPresentationStyle = .fullScreen
        cityVC.modalTransitionStyle = .coverVertical
        self.present(cityVC, animated: true, completion: nil)
        viewModel.selection.selectionChanged()
    }
    
    @objc func insuranceViewTapped(sender: HighlightView!) {
        let uploadVC = UploadViewController()
        uploadVC.viewModel = UploadViewModel(driver: self.viewModel.driver, isPresentedByConfirmVC: true)
        uploadVC.modalPresentationStyle = .fullScreen
        uploadVC.modalTransitionStyle = .coverVertical
        self.present(uploadVC, animated: true, completion: nil)
        viewModel.selection.selectionChanged()
    }
    
    @objc func uploadButtonTapped(sender: UIButton!) {
        let alert = UIAlertController(title: "Hooray!", message: "Your application is complete! Please wait for a few days while we review your submission.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Sounds good! 🥳", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        viewModel.notification.notificationOccurred(.success)
    }
}
