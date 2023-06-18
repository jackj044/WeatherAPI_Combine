//
//  LocationSearchView.swift
//  WeatherPOC
//
//  Created by Jack on 6/14/23.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var searchText: String = ""
    @Environment(\.dismiss) var dismiss
    @ObservedObject var locatinoSearchViewModel = LocationSearchViewModel()
    var callBackSearchResponse : (_ selectedSearchData : SearchResponse) -> ()
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "magnifyingglass")
                    .renderingMode(.original)
                    .foregroundColor(.black)
                    .padding(.leading,20)
                TextField("Search here", text: $searchText)
                    .onSubmit {
                        locatinoSearchViewModel.searchData = []
                        locatinoSearchViewModel.searchCities(searchText)
                    }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: 44
            )
            .background(.gray.opacity(0.4))
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.gray, lineWidth: 1))
            .padding()
            
            
            
            if (locatinoSearchViewModel.isLoading){
                Spacer()
                ProgressView()
            } else {
                if locatinoSearchViewModel.searchData.count > 0 {
                    List(locatinoSearchViewModel.searchData, id: \.id) { place in
                        
                        HStack{
                            Text(locatinoSearchViewModel.flag(country:place.country))
                            Text(place.name + ", " + place.state + ", " + place.country)
                            
                        }
                        .onTapGesture {
                            print("Tapped cell: \(place.name)")
                            callBackSearchResponse(place)
                            dismiss()
                        }
                    }
                } else {
                    Spacer()
                    Text("No Data Found")
                }
                
            }
            Spacer()
            
        }
        .navigationTitle("Search Location")
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(callBackSearchResponse: {response in})
    }
}
