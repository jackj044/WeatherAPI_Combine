//
//  HomeViewModel.swift
//  WeatherPOC
//
//  Created by Jack on 6/14/23.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

class DashboardViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var weatherResponse: WeatherData?
    
    private var cancellables = Set<AnyCancellable>()
    
    // API Call for get weather
    func getWeather(lat: Double, long: Double) async {
        DispatchQueueMain.async {
            self.isLoading = true
        }
        
        let request = WeatherRequest(lat: lat, long: long)
        
        await NetworkManager.shared.makeNetworkCall(endpoint: .getWeather, httpMethod: .GET, parameters: request.toJSON,type: WeatherData.self).sink { completion in
            self.isLoading = false
            switch completion {
            case .failure(let err):
                print("Error is \(err.localizedDescription)")
            case .finished:
                print("Finished")
            }
        } receiveValue: { [weak self] data  in
            
            self?.isLoading = false
            self?.weatherResponse = data
            
        }
        .store(in: &cancellables)
    }
    
    /// Store selected location in userDefaults
    
    func storeSelectedLocation(_ location: SearchResponse) {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(location) {
            AppUserDefaults.set(encoded, forKey: UserDefaultSelectedLocation)
        }
    }
    
    /// This method manage API call based on certain conditions as below
    /// > 1. If user checked for searched last location Ex: London , When user will open app at that time application will show weather of last searched location
    /// > 2. If user have location permission & updated location at that time App will show weather data of current location
    /// > 3. If user have no any searched location either not turn on location at that time app will show default loaction data
    
    func getSelectedLocation(currentLocation: CLLocationCoordinate2D?) async{
        
        if let savedLocation = AppUserDefaults.object(forKey: UserDefaultSelectedLocation) as? Data {
            let decoder = JSONDecoder()
            if let selectedLocation = try? decoder.decode(SearchResponse.self, from: savedLocation) {
                await getWeather(lat: selectedLocation.lat, long: selectedLocation.lon)
            }
        } else {
            
            if let currentLocation = currentLocation {
                await getWeather(lat: currentLocation.latitude, long: currentLocation.longitude)
            } else {
                await getWeather(lat: DefaultLatitude, long: DefaultLongitude)
            }
        }
    }
}
