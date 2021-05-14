//
//  UploadViewController.swift
//  DriverApp
//
//  Created by Michael Winailan on 5/11/21.
//

import UIKit
import CropViewController

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let progressView = AdjustableProgessView()
    var viewModel: UploadViewModel! {
        didSet {
            progressView.progress = viewModel.progress
        }
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if viewModel == nil {
            viewModel = UploadViewModel(driver: nil, isPresentedByConfirmVC: false)
        }
    
        self.view!.backgroundColor = UIColor(named: "BackgroundColor")

        progressView.progressTintColor = UIColor(named: "ProgressTintColor")
        progressView.trackTintColor = UIColor.white
        self.view!.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.widthAnchor.constraint(equalToConstant: 115).isActive = true
        progressView.leadingAnchor.constraint(equalTo: self.view!.leadingAnchor, constant: 39).isActive = true
        progressView.topAnchor.constraint(equalTo: self.view!.topAnchor, constant: 141).isActive = true
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 1.75)


        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Gilroy-ExtraBold", size: 30)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.text = "Upload a picture of your vehicle insurance"
        self.view!.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: 288).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view!.leadingAnchor, constant: 39).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view!.topAnchor, constant: 188).isActive = true


        let uploadButton = UIButton(type: .system)
        uploadButton.addTarget(self, action: #selector(self.uploadButtonTapped), for: .touchUpInside)
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
        uploadButton.bottomAnchor.constraint(equalTo: self.view!.bottomAnchor, constant: -62).isActive = true

    }

    // MARK: - Action Functions
    @objc func uploadButtonTapped(sender: UIButton!) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        viewModel.impact.impactOccurred()
    }

    // MARK: - ImagePicker Delegate Functions
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage

        picker.dismiss(animated: true) {
            let cropVC = CropViewController(image: pickedImage ?? UIImage())
            cropVC.delegate = self

            cropVC.title = "Make sure all information is visible"
            cropVC.imageCropFrame = CGRect(x: 0, y: 0, width: 4288, height: 2926)
            cropVC.aspectRatioLockEnabled = true
            cropVC.aspectRatioPickerButtonHidden = true
            cropVC.resetButtonHidden = true
            cropVC.rotateButtonsHidden = true

            self.present(cropVC, animated: true, completion: nil)
        }
    }
}

extension UploadViewController: CropViewControllerDelegate {
    // MARK: - CropViewController Delegate Functions
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        // 'image' is the newly cropped version of the original image
        self.viewModel.driver.insuranceImage = image
        viewModel.presentNewVC(cropVC: cropViewController)
    }
}
