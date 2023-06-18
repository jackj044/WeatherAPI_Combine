//
//  HomeWeatherDetailView.swift
//  WeatherPOC
//
//  Created by Jack on 6/15/23.
//

import SwiftUI

struct DashboardWeatherDetailView: View {
    var weatherResponse: WeatherData?
    var body: some View {
        // MARK: - Multiple Weather Details
        ZStack {
            Color.gray.opacity(0.4)
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Text("Wind: ").font(.system(size: 15))
                        Text("\(weatherResponse?.wind?.speed ?? 0)mph").font(.system(size: 15))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    HStack{
                        
                        Text("Pressure: ").font(.system(size: 15))
                        Text(String(format: "%.2finHg", (weatherResponse?.main?.pressure ?? 0)/33.864)).font(.system(size: 15))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    
                }.padding()
                Divider()
                Spacer()
                VStack(alignment: .leading){
                    
                    HStack{
                        Text("Humidity: ").font(.system(size: 15))
                        Text("\(weatherResponse?.main?.humidity ?? 0)%").font(.system(size: 15))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    HStack{
                        Text("Visibility: ").font(.system(size: 15))
                        let distanceMeters = Measurement(value: weatherResponse?.visibility ?? 0, unit: UnitLength.meters)
                        let miles = distanceMeters.converted(to: UnitLength.miles).value
                        Text(String(format: "%.2fmi", miles)).font(.system(size: 15))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    
                }.padding()
                
                
            }
        }
        
        .cornerRadius(15)
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 100)
        .padding(.top,20)
    }
}

struct HomeWeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardWeatherDetailView()
    }
}
