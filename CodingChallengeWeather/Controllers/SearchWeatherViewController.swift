//
//  ViewController.swift
//  CodingChallengeWeather
//  Created by DGF on 5/31/23.
//

import UIKit
import CoreLocation

class SearchWeatherViewController: UIViewController {
    let segueIdentifier = "weatherDetailsSegue"
    var userPreferences: any UserPreferencesProtocol = UserPreferences()
    var weatherFetcher: (any WeatherFetcherProtocol)?
    var locationManager: (any LocationProtocol) = LocationManager()
    private var weather: WeatherResponse?
    
    @IBOutlet weak var serachLabel: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up of our services
        weatherFetcher = APIWeatherFetcher(preferences: userPreferences)
        locationManager.delegate = self
        locationManager.requestCurrentLocation()
        
        serachLabel.text = userPreferences.lastCitySearched
    }
    
    @IBAction func searchLabel(_ sender: Any) {
        if let city = serachLabel.text {
            weatherFetcher?.fetchWeather(of: city){ [weak self] response, error in
                 guard let response = response else  {
                    return
                }
                
                self?.weather = response
                
                self?.performSegue(withIdentifier: self?.segueIdentifier ?? "", sender: nil)
            }
        }
        serachLabel.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard let detailVC = segue.destination as? DetailWeatherViewController, let weather = self.weather else { return }
            detailVC.weather = weather
        }
    }
}

//MARK: SearchWeatherViewController Implementation
extension SearchWeatherViewController: LocationDelegateProtocol {
    func onLocationReceived(_ currentLocation: CLLocation) {
        //consume web service here
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        
        weatherFetcher?.fetchWeather(latitude: latitude, longitude: longitude, completion: { [weak self] response, error in
            guard let response = response else { return }
            print("coordinates: \(currentLocation)")
            print("weather by coordinates: \(response)")
            self?.weather = response
            self?.performSegue(withIdentifier: self?.segueIdentifier ?? "", sender: nil)
        })
    }
    
    func onLocationReceivedWithError(_ error: CLError) {
        print(error)
    }
}

