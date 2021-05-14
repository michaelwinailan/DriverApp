//
//  CityTableViewCell.swift
//  DriverApp
//
//  Created by Michael Winailan on 5/11/21.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    let cityNameButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        cityNameButton.backgroundColor = UIColor(named: "FieldBackgroundColor")
        cityNameButton.setTitleColor(.black, for: .normal)
        cityNameButton.titleLabel?.font = UIFont(name: "Gilroy-Light", size: 14)
        cityNameButton.contentHorizontalAlignment = .left
        cityNameButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 31, bottom: 0, right: 0)
        cityNameButton.layer.cornerRadius = 24
        cityNameButton.layer.borderWidth = 1
        cityNameButton.layer.borderColor = UIColor(named: "FieldBorderColor")?.cgColor
        self.addSubview(cityNameButton)
        cityNameButton.translatesAutoresizingMaskIntoConstraints = false
        cityNameButton.widthAnchor.constraint(equalToConstant: 294).isActive = true
        cityNameButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        cityNameButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        cityNameButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title: String, target: CityViewController, action: Selector) {
        cityNameButton.addTarget(target, action: action, for: .touchUpInside)
        cityNameButton.setTitle(title, for: .normal)
    }
}
