//
//  LocationSearchViewModel.swift
//  WeatherPOC
//
//  Created by Jack on 6/14/23.
//

import Foundation
import SwiftUI
import Combine

class LocationSearchViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var searchData : [SearchResponse] = []
    @Published var selectedSearchData : SearchResponse?
    
    private var cancellables = Set<AnyCancellable>()
    
    func setSelectedLocation(selectedSearchData : SearchResponse?){
        self.selectedSearchData = selectedSearchData
    }
    
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var str = ""
        for val in country.unicodeScalars {
            str.unicodeScalars.append(UnicodeScalar(base + val.value)!)
        }
        return String(str)
    }
    
    func searchCities(_ text:String?) async{
        
        let request = SearchRequest(keyword: text ?? "")
       await NetworkManager.shared.makeNetworkCall(endpoint: Endpoint.place, httpMethod: .GET, parameters: request.toJSON,type: [SearchResponse].self).sink { completion in
            switch completion {
            case .failure(let err):
                print("Error is \(err.localizedDescription)")
            case .finished:
                print("Finished")
            }
            
        } receiveValue: { [weak self] data  in
            self?.searchData = data
        }
        .store(in: &cancellables)
        
    }
}
