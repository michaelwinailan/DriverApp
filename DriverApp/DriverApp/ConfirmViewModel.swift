//
//  ConfirmViewModel.swift
//  DriverApp
//
//  Created by Michael Winailan on 5/13/21.
//

import UIKit

struct ConfirmViewModel {
    var driver:Driver
    let notification = UINotificationFeedbackGenerator()
    let selection = UISelectionFeedbackGenerator()
    
    init(driver: Driver?) {
        self.driver = driver ?? Driver()
    }
}
