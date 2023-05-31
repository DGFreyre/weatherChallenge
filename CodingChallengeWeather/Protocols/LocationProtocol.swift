//
//  LocationProtocol.swift
//  CodingChallengeWeather
//
//  Created by DGF on 5/31/23.
//

import Foundation
import CoreLocation

protocol LocationProtocol {
    var delegate: LocationDelegateProtocol? { get set }
    func requestCurrentLocation()
}

protocol LocationDelegateProtocol {
    func onLocationReceived(_ currentLocation: CLLocation)
    func onLocationReceivedWithError(_ error: CLError)
}
