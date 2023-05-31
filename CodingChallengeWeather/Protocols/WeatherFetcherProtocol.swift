//
//  WeatherFetcherProtocol.swift
//  CodingChallengeWeather
//
//  Created by DGF on 5/31/23.
//

import Foundation

protocol WeatherFetcherProtocol {
    
    func fetchWeather(of cityName: String, completion: @escaping (WeatherResponse?, WeatherError?) -> Void)
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResponse?, WeatherError?) -> Void)
}

enum WeatherError: Error {
    case APIFailed
    case InvalidFormat
}
