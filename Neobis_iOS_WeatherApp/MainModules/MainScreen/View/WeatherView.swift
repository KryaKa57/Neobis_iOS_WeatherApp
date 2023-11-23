//
//  WeatherView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alisher on 23.11.2023.
//

import Foundation
import UIKit
import SnapKit

class WeatherView: UIView {
    
    private let systemBounds = UIScreen.main.bounds
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor(rgb: 0x30A2C5).cgColor,
            UIColor(rgb: 0x00242F).cgColor
        ]
        gradient.locations = [0, 1]
        return gradient
    }()
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.text = "Today, May 7th, 2021"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "Barcelona"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Spain"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currentStatusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "snow")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "20°C"
        label.font = UIFont.systemFont(ofSize: 72, weight: .light)
        return label
    }()
    
    private lazy var whiteCircleCiew: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = (systemBounds.height * 0.25) / 2
        view.layer.shadowColor = UIColor(rgb: 0x60D1EA).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 36
             
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var additionalInfoStackView: UIStackView = {
        let stack = UIStackView()
        let statusTitles = ["Wind status","Humidity","Visibility","Air pressure"]
        let statusMeasures = ["mph","%","miles","mb"]
        
        let statusValue = [7, 85, 6.4, 998]
        
        for i in [0, 2] {
            let subView = UIStackView()
            for j in [0, 1] {
                let index = i + j
                let statusLabel = UILabel()
                statusLabel.text = statusTitles[index]
                statusLabel.textColor = .white
                statusLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                
                let statusValueLabel = UILabel()
                statusValueLabel.text = "\(statusValue[index]) \(statusMeasures[index])"
                statusValueLabel.textColor = .white
                statusValueLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
                
                subView.addArrangedSubview(statusLabel)
                subView.addArrangedSubview(statusValueLabel)
                
                subView.setCustomSpacing(20, after: statusLabel)
            }
            subView.distribution = .fillProportionally
            subView.alignment = .center
            subView.spacing = 30
            subView.axis = .vertical
            stack.addArrangedSubview(subView)
        }
        stack.distribution = .fillEqually
        
        stack.alignment = .fill
        stack.spacing = 48
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var weeklyCollectionView: UICollectionView = {

        let dailyLayoutCollectionView = UICollectionViewFlowLayout()
        dailyLayoutCollectionView.scrollDirection = .horizontal
        dailyLayoutCollectionView.itemSize = CGSize(width: systemBounds.width*0.16, height: systemBounds.height * 0.16)
        dailyLayoutCollectionView.sectionHeadersPinToVisibleBounds = true

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: dailyLayoutCollectionView)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.layer.cornerRadius = 32
        collectionView.frame = view.bounds
        
        collectionView.register(DailyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DailyWeatherCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self,
                                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: HeaderCollectionReusableView.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var view = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        addSubview(view)
        gradient.frame = systemBounds
        view.layer.addSublayer(gradient)
        
        view.addSubview(dataLabel)
        view.addSubview(cityLabel)
        view.addSubview(countryLabel)
        view.addSubview(whiteCircleCiew)
        view.addSubview(currentStatusImageView)
        view.addSubview(currentTemperatureLabel)
        view.addSubview(additionalInfoStackView)
        view.addSubview(weeklyCollectionView)
    }
    
    private func setConstraints() {
        self.view.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        self.dataLabel.snp.makeConstraints {(make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(systemBounds.height * 0.1)
        }
        self.cityLabel.snp.makeConstraints {(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(dataLabel.snp.bottom).offset(8)
        }
        self.countryLabel.snp.makeConstraints {(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityLabel.snp.bottom)
        }
        self.whiteCircleCiew.snp.makeConstraints {(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(countryLabel.snp.bottom).offset(24)
            make.width.height.equalTo(systemBounds.height * 0.25)
        }
        self.currentStatusImageView.snp.makeConstraints {(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(whiteCircleCiew.snp.top).offset(8)
            make.width.height.equalTo(whiteCircleCiew.snp.height).multipliedBy(0.3)
        }
        self.currentTemperatureLabel.snp.makeConstraints {(make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(currentStatusImageView.snp.bottom)
            make.bottom.lessThanOrEqualTo(whiteCircleCiew.snp.bottom).offset(8)
        }
        self.additionalInfoStackView.snp.makeConstraints {(make) in
            make.top.equalTo(whiteCircleCiew.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(32)
        }
        self.weeklyCollectionView.snp.makeConstraints {(make) in
            make.top.equalTo(additionalInfoStackView.snp.bottom).offset(32)
            make.bottom.width.equalToSuperview()
        }
    }
}
