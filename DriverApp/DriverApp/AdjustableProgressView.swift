//
//  AdjustableProgressView.swift
//  DriverApp
//
//  Created by Michael Winailan on 5/13/21.
//

import UIKit

// AdjustableProgessView allows the UIProgressView to resize/transform while maintaining its corner radius without being stretched.
class AdjustableProgessView: UIProgressView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 4.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskLayerPath.cgPath
        layer.mask = maskLayer
    }
}
