//
//  SearchRequest.swift
//  WeatherPOC
//
//  Created by Jack on 6/14/23.
//

import Foundation

struct SearchRequest {
    
    let keyword: String
    
    var toJSON: [String: Any] {
        
        return ["q": keyword,
                "limit": "100",
                "appid": OpenWeatherApiKey]
    }
}
