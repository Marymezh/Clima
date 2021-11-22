//
//  WeatherManager.swift
//  Clima
//
//  Created by Maria Mezhova on 22.11.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/find?appid=10fec9b6798b0c5d2539db70285c3845&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
