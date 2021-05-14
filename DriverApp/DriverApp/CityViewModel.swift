//
//  CityViewModel.swift
//  DriverApp
//
//  Created by Michael Winailan on 5/13/21.
//

import UIKit

struct CityViewModel {
    var driver:Driver
    var operatingCities:[String] = ["Austin", "Houston", "San Antonio", "Dallas"]
    let impact = UIImpactFeedbackGenerator()
    
    init(driver: Driver?) {
        self.driver = driver ?? Driver()
    }
    
    func setCellTitle(cell: CityTableViewCell, indexPath: IndexPath, cityVC: CityViewController) {
        if indexPath.row < self.operatingCities.count {
            cell.setTitle(title: self.operatingCities[indexPath.row], target: cityVC, action: #selector(cityVC.cityNameButtonTapped))
        } else {
            cell.setTitle(title: "Other", target: cityVC, action: #selector(cityVC.cityOtherButtonTapped))
        }
    }
}
