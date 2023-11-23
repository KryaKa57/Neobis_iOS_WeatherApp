//
//  ViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alisher on 23.11.2023.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    private let systemBounds = UIScreen.main.bounds
    private var weatherData: [Weather] = []
    
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
        imageView.image = UIImage(named: "weather_snow")
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
                
                subView.setCustomSpacing(16, after: statusLabel)
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
    
    private lazy var weeklyCollectionView: UICollectionView = {

        let dailyLayoutCollectionView = UICollectionViewFlowLayout()
        dailyLayoutCollectionView.scrollDirection = .horizontal
        dailyLayoutCollectionView.itemSize = CGSize(width: view.frame.size.width*0.8, height: view.frame.size.height * 0.08)
        dailyLayoutCollectionView.sectionHeadersPinToVisibleBounds = true

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: dailyLayoutCollectionView)
        collectionView.backgroundColor = .white
        collectionView.frame = view.bounds
        collectionView.register(DailyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DailyWeatherCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self,
                                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: HeaderCollectionReusableView.identifier)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigation()
        self.initialize()
        self.setConstraints()
    }
    
    private func setNavigation() {
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold))
        let rightBarButton = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)
        
        rightBarButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func initialize() {
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        
        view.addSubview(dataLabel)
        view.addSubview(cityLabel)
        view.addSubview(countryLabel)
        view.addSubview(whiteCircleCiew)
        view.addSubview(currentStatusImageView)
        view.addSubview(currentTemperatureLabel)
        view.addSubview(additionalInfoStackView)
        view.addSubview(weeklyCollectionView)
        
        weeklyCollectionView.delegate = self
        weeklyCollectionView.dataSource = self
    }
    
    private func setConstraints() {
        self.dataLabel.snp.makeConstraints {(make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(systemBounds.height * 0.15)
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
        }
    }
    
    private func fillInTheData() {
            weatherData.append(Weather(date: "Апр, 26", hour: "15.00", statusImageName: "cloudy-sunny", degree: 29))
            weatherData.append(Weather(date: "Апр, 26", hour: "16.00", statusImageName: "cloudy-sunny", degree: 26))
            weatherData.append(Weather(date: "Апр, 26", hour: "17.00", statusImageName: "cloudy", degree: 24))
            weatherData.append(Weather(date: "Апр, 26", hour: "18.00", statusImageName: "cloudy-night", degree: 23))
            weatherData.append(Weather(date: "Апр, 26", hour: "19.00", statusImageName: "cloudy-night", degree: 22))
            
            weatherData.append(Weather(date: "Апр, 26", hour: "-", statusImageName: "rainy-thunder", degree: 21))
            weatherData.append(Weather(date: "Апр, 27", hour: "-", statusImageName: "cloudy", degree: 22))
            weatherData.append(Weather(date: "Апр, 28", hour: "-", statusImageName: "sunny", degree: 34))
            weatherData.append(Weather(date: "Апр, 29", hour: "-", statusImageName: "cloudy", degree: 27))
            weatherData.append(Weather(date: "Апр, 30", hour: "-", statusImageName: "cloudy-sunny", degree: 32))
            weatherData.append(Weather(date: "Май, 1", hour: "-", statusImageName: "cloudy", degree: 29))
            weatherData.append(Weather(date: "Май, 2", hour: "-", statusImageName: "rainy", degree: 24))
            weatherData.append(Weather(date: "Май, 3", hour: "-", statusImageName: "rainy", degree: 22))
            weatherData.append(Weather(date: "Май, 4", hour: "-", statusImageName: "rainy-thunder", degree: 21))
            weatherData.append(Weather(date: "Май, 5", hour: "-", statusImageName: "sunny", degree: 28))
            weatherData.append(Weather(date: "Май, 6", hour: "-", statusImageName: "sunny", degree: 31))
            weatherData.append(Weather(date: "Май, 7", hour: "-", statusImageName: "cloudy-sunny", degree: 27))
        }
    
    @objc func goToNextScreen(sender: UIButton) {
    }
}


extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCollectionViewCell.identifier, for: indexPath) as! DailyWeatherCollectionViewCell
        cell.configure(weather: weatherData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        headerView.configure()
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize()
    }
}
