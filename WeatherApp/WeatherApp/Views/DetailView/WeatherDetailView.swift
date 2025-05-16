//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Ximena Rotceh Mendoza Gamino on 14/05/25.
//

import SwiftUI



struct WeatherDetailView: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        List {
            if (viewModel.historicalWeather != nil) {
                Section(header: Text("Temperaturas")) {
                    HStack {
                        Text("Mínima")
                        Spacer()
                        Text(viewModel.formatted(viewModel.minTemperature, unit: viewModel.temperatureUnit))
                    }
                    
                    HStack {
                        Text("Máxima")
                        Spacer()
                        Text(viewModel.formatted(viewModel.maxTemperature, unit: viewModel.temperatureUnit))
                    }
                }
                
                Section(header: Text("Otros datos")) {
                    HStack {
                        Text("Humedad")
                        Spacer()
                        Text(viewModel.formatted(viewModel.latestHumidity, unit: viewModel.humidityUnit))
                    }
                    
                    HStack {
                        Text("Viento")
                        Spacer()
                        Text(viewModel.formatted(viewModel.latestWind, unit: viewModel.windUnit))
                    }
                }
            }else {
                ProgressView("Cargando clima...")
            }
        }.onAppear {
            self.viewModel.getHistoricalWeather()
        }
    }


}

