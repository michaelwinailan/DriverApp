//
//  UploadViewModel.swift
//  DriverApp
//
//  Created by Michael Winailan on 5/12/21.
//

import UIKit
import CropViewController

struct UploadViewModel {
    let driver:Driver
    var progress:Float = 0
    var isPresentedByConfirmVC:Bool = false
    let impact = UIImpactFeedbackGenerator()
    
    init(driver: Driver?, isPresentedByConfirmVC: Bool) {
        self.driver = driver ?? Driver()
        self.isPresentedByConfirmVC = isPresentedByConfirmVC
        
        if self.isPresentedByConfirmVC == true {
            self.progress = 0.67
        } else {
            self.progress = 0.22
        }
    }
    
    func presentNewVC(cropVC: CropViewController) {
        if self.isPresentedByConfirmVC == true {
            let confirmVC = ConfirmViewController()
            confirmVC.viewModel = ConfirmViewModel(driver: self.driver)
            confirmVC.modalPresentationStyle = .fullScreen
            confirmVC.modalTransitionStyle = .coverVertical
            cropVC.present(confirmVC, animated: true, completion: nil)
        } else {
            let cityVC = CityViewController()
            cityVC.viewModel = CityViewModel(driver: self.driver)
            cityVC.modalPresentationStyle = .fullScreen
            cityVC.modalTransitionStyle = .coverVertical
            cropVC.present(cityVC, animated: true, completion: nil)
        }
    }
}
