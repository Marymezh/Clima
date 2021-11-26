//
//  WeatherManager.swift
//  Clima
//
//  Created by Maria Mezhova on 22.11.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/find?appid=10fec9b6798b0c5d2539db70285c3845&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
        print (urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees , longitude: CLLocationDegrees ) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
        print (urlString)
    }
    
    
    func performRequest(with urlString: String) {
        // 1. create a URL
        guard let url = URL(string: urlString) else { return }
        // 2.create a URLSession
        
        let session = URLSession(configuration: .default)
        // 3. give the session a task
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            if let safeData = data {
                guard let weather = parseJSON(safeData) else { return }
                self.delegate?.didUpdateWeather(self, weather)
            }
        }
        
        // 4. start the task
        
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.list[0].weather[0].id
            let temp = decodedData.list[0].main.temp
            let description = decodedData.list[0].weather[0].description
            let cityName = decodedData.list[0].name
            
            let weather = WeatherModel(conditionID: id, description: description, cityName: cityName, temperature: temp)
          return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

    
    
}
