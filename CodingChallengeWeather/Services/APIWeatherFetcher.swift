//
//  APIWeatherFetcher.swift
//  CodingChallengeWeather
//
//  Created by DGF on 5/31/23.
//

import Foundation

class APIWeatherFetcher: WeatherFetcherProtocol {
    private var preferences: any UserPreferencesProtocol
    
    init(preferences: any UserPreferencesProtocol) {
        self.preferences = preferences
    }
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResponse?, WeatherError?) -> Void) {
        let endpoint = "\(WeatherAPIConstants.endpoint)?lat=\(latitude)&lon=\(longitude)&appid=\(WeatherAPIConstants.appKey)"
        
        let url = URL(string: endpoint)!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            if  error != nil {
                print("error \(error!)")
                return
            }
            
            if let safeData = data {
                let decoder = JSONDecoder()
                do {
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: safeData)
                    DispatchQueue.main.async {
                        completion(weatherResponse, nil)
                    }
                } catch {
                    print(error)
                    completion(nil, WeatherError.InvalidFormat)
                }
            }
        }
        
        task.resume()
    }
    
    func fetchWeather(of cityName: String, completion: @escaping (WeatherResponse?, WeatherError?) -> Void) {
        let endpoint = "\(WeatherAPIConstants.endpoint)?q=\(cityName)&appid=\(WeatherAPIConstants.appKey)"
        //TODO: validate if the city is valid
        preferences.lastCitySearched = cityName
        let url = URL(string: endpoint)!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            if  error != nil {
                print("error \(error!)")
                return
            }
            
            if let safeData = data {
                let decoder = JSONDecoder()
                do {
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: safeData)
                    DispatchQueue.main.async {
                        completion(weatherResponse, nil)
                    }
                } catch {
                    print(error)
                    completion(nil, WeatherError.InvalidFormat)
                }
            }
        }
        
        task.resume()
    }
}
