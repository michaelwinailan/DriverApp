//
//  CityViewController.swift
//  DriverApp
//
//  Created by Michael Winailan on 5/11/21.
//

import UIKit

class CityViewController: UIViewController {
    let progressView = AdjustableProgessView()
    let citiesTableView = UITableView()
    var viewModel:CityViewModel! {
        didSet {
            citiesTableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view!.backgroundColor = UIColor(named: "BackgroundColor")
        
        progressView.progress = 0.67
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
        titleLabel.text = "What city are you based in?"
        self.view!.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.widthAnchor.constraint(equalToConstant: 288).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.view!.leadingAnchor, constant: 39).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view!.topAnchor, constant: 188).isActive = true
        
    
        citiesTableView.register(CityTableViewCell.self, forCellReuseIdentifier: "cityReusableCell")
        citiesTableView.separatorStyle = .none
        citiesTableView.backgroundColor = .clear
        citiesTableView.allowsSelection = false
        citiesTableView.isUserInteractionEnabled = true
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        self.view!.addSubview(citiesTableView)
        citiesTableView.translatesAutoresizingMaskIntoConstraints = false
        citiesTableView.widthAnchor.constraint(equalToConstant: 294).isActive = true
        citiesTableView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        citiesTableView.leadingAnchor.constraint(equalTo: self.view!.leadingAnchor, constant: 33).isActive = true
        citiesTableView.bottomAnchor.constraint(equalTo: self.view!.bottomAnchor, constant: -69).isActive = true
        
    }
    
    // MARK: - Action Functions
    @objc func cityNameButtonTapped(sender: UIButton) {
        self.viewModel.driver.city = sender.titleLabel?.text ?? "Austin"
        
        let confirmVC = ConfirmViewController()
        confirmVC.viewModel = ConfirmViewModel(driver: self.viewModel.driver)
        confirmVC.modalPresentationStyle = .fullScreen
        confirmVC.modalTransitionStyle = .coverVertical
        self.present(confirmVC, animated: true, completion: nil)
        viewModel.impact.impactOccurred()
    }
    
    @objc func cityOtherButtonTapped(sender: UIButton) {
        // TODO: Add new features in this empty view controller
        let otherCityVC = UIViewController()
        otherCityVC.modalPresentationStyle = .fullScreen
        otherCityVC.modalTransitionStyle = .coverVertical
        self.present(otherCityVC, animated: true, completion: nil)
        viewModel.impact.impactOccurred()
    }
    
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - TableView Delegate Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.operatingCities.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityReusableCell") as! CityTableViewCell
        viewModel.setCellTitle(cell: cell,indexPath: indexPath, cityVC: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //cityNameButton height + top and bottom space
        return 48 + 16
    }
}

