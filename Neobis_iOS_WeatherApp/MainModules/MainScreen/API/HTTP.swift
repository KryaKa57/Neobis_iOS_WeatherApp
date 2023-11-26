//
//  HTTP.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alisher on 26.11.2023.
//

import Foundation

enum HTTP {
    enum Method: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Headers {
        enum Key: String {
            case apiKey = "X-CMC_PRO_API_KEY"
        }
    }
}
