//
//  EndPoint.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alisher on 26.11.2023.
//

import Foundation

enum Endpoint {
    
    case fetchData(url: String = "/data/2.5/forecast", city: String = "London")
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.port = nil
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
        case .fetchData(let url, _):
            return url
        }
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .fetchData(_, let city):
            return [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "appid", value: "72f1e5547d5696fa1f927c285474886b")
            ]
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchData:
            return HTTP.Method.get.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchData:
            return nil
        }
    }
}

