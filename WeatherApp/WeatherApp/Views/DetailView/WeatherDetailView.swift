//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Ximena Rotceh Mendoza Gamino on 14/05/25.
//

import SwiftUI

struct WeatherDetailView: View {
    //let weather: WeatherData
    
    var body: some View {
        List {
            Section(header: Text("Temperaturas")) {
                HStack {
                    Text("Mínima")
                    Spacer()
                    Text("30 °C")
                }

                HStack {
                    Text("Máxima")
                    Spacer()
                    Text("30 °C")
                }
            }

            Section(header: Text("Otros datos")) {
                HStack {
                    Text("Humedad")
                    Spacer()
                    Text("30 %")
                }

                HStack {
                    Text("Viento")
                    Spacer()
                    Text("60 m/s")
                }
            }
        }
        //.navigationTitle("Detalles de \(weather.cityName)")
    }
}

#Preview {
    WeatherDetailView()
}
