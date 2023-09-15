//
//  WeatherModel.swift
//  Clima
//
//  Created by Aswin Kumaran on 6/8/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    //This is a variable that takes a function as its input
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionID{
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud"
            default:
                return "cloud.rain"
        }
    }
}
