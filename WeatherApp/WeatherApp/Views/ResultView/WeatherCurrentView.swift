//
//  WeatherCurrentView.swift
//  WeatherApp
//
//  Created by Ximena Rotceh Mendoza Gamino on 14/05/25.
//

import SwiftUI

struct WeatherCurrentView: View {
    @EnvironmentObject var viewModel: WeatherViewModel

    var body: some View {
        VStack(spacing: 20) {
//            if let weather = viewModel.weather {
                Text("México")
                    .font(.largeTitle)
                    .bold()

                Text(" 30 C")
                    .font(.system(size: 64))
                    .bold()

                Text("El clima es frio")
                    .font(.title2)
                    .foregroundColor(.gray)

//             pñ´{{{´{{{{{{
                .padding(.top, 20)
//            } else {
//                ProgressView("Cargando clima...")
//            }
        }
        .padding()
        .navigationTitle("Clima actual")
        .onAppear{
            self.viewModel.getCoordinatesAndThenFetchWeather()
        }
    }
        
}


#Preview {
    WeatherCurrentView()
}
