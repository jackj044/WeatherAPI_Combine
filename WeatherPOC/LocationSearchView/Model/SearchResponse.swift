//
//  SearchResponse.swift
//  WeatherPOC
//
//  Created by Jack on 6/14/23.
//

import Foundation

struct SearchResponse: Codable,Identifiable {
    var id: String? = UUID().uuidString
    let name: String
    let lat, lon: Double
    let country, state: String
    let localNames: LocalNames?

    enum CodingKeys: String, CodingKey {
        case name, lat, lon, country, state
        case localNames = "local_names"
    }
}

struct LocalNames: Codable,Identifiable {
    var id: String? = UUID().uuidString
    let en: String
}
