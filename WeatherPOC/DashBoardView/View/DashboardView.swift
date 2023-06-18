//
//  HomeView.swift
//  WeatherPOC
//
//  Created by Jack on 6/14/23.
//

import SwiftUI
import Kingfisher
import CoreLocation

struct DashboardView: View {
    @ObservedObject var dashboardViewModel = DashboardViewModel()
    @ObservedObject var locationManager = LocationManager()
    @State private var selectedSearch:SearchResponse?
    
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LoadingView(isShowing:dashboardViewModel.isLoading) {
                    VStack {
                        // MARK: - Search Location View
                        HStack{
                            
                            NavigationLink(destination: LocationSearchView(callBackSearchResponse: { place in
                                self.selectedSearch = place
                                dashboardViewModel.storeSelectedLocation(place)
                                
                            })) {
                                HStack{
                                    
                                    Image(systemName: "magnifyingglass")
                                        .renderingMode(.original)
                                        .foregroundColor(.black)
                                        .padding(.leading,20)
                                    Text(
                                        (dashboardViewModel.weatherResponse?.name  ?? "") + ", " + (dashboardViewModel.weatherResponse?.sys?.country  ?? "")
                                    )
                                    .foregroundColor(.black)
                                    .cornerRadius(15)
                                    Spacer()
                                }
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: 50
                                )
                                .background(.gray.opacity(0.4))
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(.gray, lineWidth: 1))
                            }
                            
                        }
                        
                        // MARK: - Main Temprature Details
                        DashboardWeatherView(weatherResponse: dashboardViewModel.weatherResponse)
                        // MARK: - Multiple Weather Details
                        DashboardWeatherDetailView(weatherResponse: dashboardViewModel.weatherResponse)
                        
                        Spacer()
                    }
                    .onAppear {
                        locationManager.callBackUpdatedLocation = { currentLocation in
                            dashboardViewModel.getSelectedLocation(currentLocation: currentLocation)
                        }
                        dashboardViewModel.getSelectedLocation(currentLocation: locationManager.lastLocation)
                    }
                    .navigationTitle("Weather")
                    .padding()
                    
                }
            }
            
            
            
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
