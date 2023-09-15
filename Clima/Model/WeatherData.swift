//
//  WeatherData.swift
//  Clima
//
//  Created by Aswin Kumaran on 6/3/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

//This is a struct created to handle all JSON data that we decoded from the JSON decoder. Notice how it has the Decodable protocol
struct WeatherData: Decodable{
    //It also needs to have the variables that we are trying to access from the JSON data. For example, when we paste the URL into our browser, we see a property called name that we are trying to access. Therefore, we must create a name property in this struct so that we can print the name from this struct
    let name: String
    let main: Main
    let weather: [Weather]
}

//When looking through the JSON data, we might see some variables that we are trying to access that are stored in arrays or even other objects. In this case, we have to use sub structs that contain the variable we are trying to acess and create an instance of the sub struct in the main struct. Notice that these sub structs also have the Decodable protocol
struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable{
    let id: Int
}
