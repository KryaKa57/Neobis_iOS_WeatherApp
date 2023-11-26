//
//  WeatherService.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Alisher on 26.11.2023.
//

import Foundation

enum WeatherServiceError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unknown(String = "An unknown error occured.")
}

class WeatherService {
    static func fetchData(with endpoint: Endpoint,
                          completition: @escaping (Result<Welcome, WeatherServiceError>)->Void) {
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) {data, resp, error in
            if let error = error {
                completition(.failure(.unknown(error.localizedDescription)))
                return
            }

            if let resp = resp as? HTTPURLResponse, resp.statusCode != 200 {
                completition(.failure(.invalidResponse))
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let weatherData = try decoder.decode(Welcome.self, from: data)
                    completition(.success(weatherData))
                } catch {
                    completition(.failure(.invalidData))
                }
            } else {
                completition(.failure(.unknown()))
            }
        }.resume()
    }
}
