//
//  LocationManager.swift
//  WeatherPOC
//
//  Created by Jack on 6/14/23.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    var lastLocation: CLLocationCoordinate2D?
    var callBackUpdatedLocation: ((CLLocationCoordinate2D) async -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }

    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status

    }
    
    private func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) async {
        guard let location = locations.last else { return }
        lastLocation = location.coordinate
        await callBackUpdatedLocation?(location.coordinate)
        locationManager.delegate = nil
        locationManager.stopUpdatingLocation()
        
    }
}
