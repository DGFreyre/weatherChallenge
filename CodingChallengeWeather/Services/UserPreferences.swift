//
//  UserPreferences.swift
//  CodingChallengeWeather
//
//  Created by DGF on 5/31/23.
//

import Foundation
struct UserPreferences: UserPreferencesProtocol {
    var lastCitySearched: String {
        get {
            UserDefaults.standard.string(forKey: "lastCitySearched") ?? ""
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "lastCitySearched")
        }
    }
}
