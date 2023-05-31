//
//  DetailWeatherViewController.swift
//  CodingChallengeWeather
//
//  Created by DGF on 5/31/23.
//

import UIKit

class DetailWeatherViewController: UIViewController {

    @IBOutlet weak var temperatureLable: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    var weather: WeatherResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let weather = weather else { return }
        
        temperatureLable.text = "Max: \(weather.main.tempMax) -  \(weather.main.tempMin)"
        descriptionLabel.text = "\(String(describing: weather.main.humidity))"
        cityLabel.text = weather.name
    }
}
