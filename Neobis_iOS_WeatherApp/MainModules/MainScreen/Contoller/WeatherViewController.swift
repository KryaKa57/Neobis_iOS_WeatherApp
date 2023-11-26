//
//  ViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alisher on 23.11.2023.
//

import UIKit
import SnapKit

class WeatherViewController: UIViewController {
    private var weatherView: WeatherView!
    private var weatherViewModel: WeatherViewModel
    
    private var mainModel: Main?
    
    private let systemBounds = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createView()
        self.setNavigation()

        self.weatherViewModel.onWeatherUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.weatherView.weeklyCollectionView.reloadData()
                self?.weatherView.configure(weather: self?.weatherViewModel.weather)
            }
        }
        
    }
    
    init(viewModel: WeatherViewModel = WeatherViewModel()) {
        self.weatherViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createView() {
        weatherView = WeatherView()
        weatherView.frame = CGRect(x: 0, y: 0, width: systemBounds.width, height: systemBounds.height)
        weatherView.center = view.center
        view.addSubview(weatherView)
        
        weatherView.weeklyCollectionView.dataSource = self
        weatherView.weeklyCollectionView.delegate = self
    }
}


// MARK: Configure Navigation
extension WeatherViewController {
    private func setNavigation() {
        let image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold))
        let rightBarButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(goToNextScreen))
        
        rightBarButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func goToNextScreen() {
        var nextScreen: UIViewController
        nextScreen = SearchLocationViewController()
            
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = UIColor(rgb: 0x000000, alpha: 0)
        navigationController?.pushViewController(nextScreen, animated: true)
    }
}

// MARK: Configure UICollectionView
extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.weatherViewModel.weather?.list.count ?? 0) - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var listOfCells = self.weatherViewModel.weather?.list
        listOfCells?.removeFirst()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCollectionViewCell.identifier, for: indexPath) as! DailyWeatherCollectionViewCell
        cell.configure(weatherList: (listOfCells?[indexPath.row])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(1)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        headerView.configure()
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 1, height: 1)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
    }
}
