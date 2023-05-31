//
//  LocationManager.swift
//  CodingChallengeWeather
//
//  Created by DGF on 5/31/23.
//

import Foundation
import CoreLocation
final class LocationManager: NSObject, LocationProtocol {
    var delegate: LocationDelegateProtocol?
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyReduced
    }
    
    func requestCurrentLocation() {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            //we consume
            locationManager.requestLocation()
        } else {
            //check permission inform user
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            //we consume
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else { return }
        delegate?.onLocationReceived(currentLocation)
        //published current location
        print("current location \(currentLocation)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let clError = error as? CLError else { return }
        delegate?.onLocationReceivedWithError(clError)
    }
}
