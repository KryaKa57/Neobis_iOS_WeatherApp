//
//  WeatherViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alisher on 25.11.2023.
//

import Foundation


class WeatherViewModel {
    var onWeatherUpdated: (() -> Void)?
    var onErrorMessage: ((WeatherServiceError) -> Void)?
    
    private(set) var weather: Welcome? {
        didSet {
            self.onWeatherUpdated?()
        }
    }
    
    init() {
        self.fetchData()
    }
    
    public func fetchData() {
        let endpoint = Endpoint.fetchData()
        
        WeatherService.fetchData(with: endpoint) { [weak self] result in
            switch result {
            case .success(let weather):
                var filteredWeatherList = weather.list
                
                filteredWeatherList = filteredWeatherList.filter { element in
                    return element.dt % 86400 == 0 || element.dtTxt == weather.list.first?.dtTxt
                }
                print(filteredWeatherList.count)
                
                let filteredWeather = Welcome(cod: weather.cod, message: weather.message, cnt: filteredWeatherList.count, list: filteredWeatherList, city: weather.city)
                
                self?.weather = filteredWeather
            case .failure(let error):
                self?.onErrorMessage?(error)
            }
        }
    }
}
