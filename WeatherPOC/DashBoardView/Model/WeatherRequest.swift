//
//  WeatherRequest.swift
//  WeatherPOC
//
//  Created by Jack on 6/14/23.
//

struct WeatherRequest {
    
    let lat: Double
    let long: Double
    
    var toJSON: [String: Any] {
        
        return ["lat": lat,
                "lon": long,
                "limit": "100",
                "units": "imperial",
                "appid": OpenWeatherApiKey]
    }
}
