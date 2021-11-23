//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Maria Mezhova on 23.11.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
}
