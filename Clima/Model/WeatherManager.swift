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
        performRequest(urlString: urlString)
    }
    
    
    func performRequest(urlString: String) {
        // 1. create a URL
        guard let url = URL(string: urlString) else { return }
        // 2.create a URLSession
        
        let session = URLSession(configuration: .default)
        // 3. give the session a task
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                parseJSON(weatherData: safeData)
            }
        }
        
        // 4. start the task
        
        task.resume()
    }
    
    func parseJSON(weatherData: Data) {
        
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.list[0].name)
            print(decodedData.list[1].main.temp)
            print(decodedData.list[0].weather[0].description)
            print(decodedData.list[0].weather[0].icon)
         
            
        } catch {
            print(error)
        }
    }
    
}
