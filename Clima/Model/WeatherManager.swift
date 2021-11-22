//
//  WeatherManager.swift
//  Clima
//
//  Created by Maria Mezhova on 22.11.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/find?appid=10fec9b6798b0c5d2539db70285c3845&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlName: urlString)
    }
    
    
    func performRequest(urlName: String) {
        // 1. create a URL
        guard let url = URL(string: urlName) else { return }
        // 2.create a URLSession
        
        let session = URLSession(configuration: .default)
        // 3. give the session a task
        
        let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
        
        // 4. start the task
        
        task.resume()
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString!)
        }
    }
    
}
