//
//  WeatherManager.swift
//  Clima
//
//  Created by Aswin Kumaran on 6/3/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

//Protocol that says any class that adopts me must implement the didWeatherUpdate function that gives them access to the weather data
protocol WeatherManagerDelegate {
    func didWeatherUpdate(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=3226944725b342223ea42350b03d2b17&units=metric" //has to be https
    
    //Setting the protocol as the delegate. This actually refers to any class that adopts the protocol
    var delegate: WeatherManagerDelegate?
    
    //Modifies the weatherURL to include the city name at the end of the URL, then uses the modified URL to fetch data from the API
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    //Follows the 4 step process of making an API call
    func performRequest(with urlString: String){
        //Step 1: Create a URL
        if let url = URL(string: urlString){
            
            //Step 2: Create a URL session
            let session = URLSession(configuration: .default)
            
            //Step 3: Give the URL session a task. The session task uses a closure as its completion handler. The closure takes action when the task has ended and the data, or error, has been received
            let task = session.dataTask(with: url) { data, response, error in
                if (error != nil){
                    print(error!)
                    delegate?.didFailWithError(error: error!)
                    return //Just typing return acts as a break
                }
                
                if let safeData = data{
                    //Not required but inside closures you must add the keyword self
                    if let weather = self.parseJSON(safeData){
                        delegate?.didWeatherUpdate(self, weather: weather)
                    }
                    
                }
            }
            
            //Step 4: Start the task
            task.resume()
            
        }
    }
    
    //This function takes the data we received from the performRequest function and turns it into data we can understand.
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder() //A JSON decoder takes JSON data and turns it into a another object
        do {
            //This code turns JSON data into our custom type of data called WeatherData
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let city = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: city, temperature: temp)
            return weather
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
}

