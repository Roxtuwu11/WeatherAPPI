//
//  WeatherCurrentView.swift
//  WeatherApp
//
//  Created by Ximena Rotceh Mendoza Gamino on 14/05/25.
//

import SwiftUI

struct WeatherCurrentView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @EnvironmentObject var router: Router
    var body: some View {
        VStack(spacing: 20) {
            if let current = viewModel.currentWeather {
                Text(viewModel.city?.cityName ?? "")
                    .font(.largeTitle)
                    .bold()

                Text("\(Int(current.currentWeather!.temperature))°C")
                    .font(.system(size: 64))
                    .bold()

                Text(self.viewModel.description(for: current.currentWeather!.weathercode))
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                Button("Ver detalle del clima") {
                    router.navigateTo(route: .detail)
                               }
                               .padding(.top, 30)
                               .buttonStyle(.borderedProminent)
            } else {
                ProgressView("Cargando clima...")
            }
        }
        .alert("Error", isPresented: $viewModel.showErrorAlert) {
            Button("Reintentar", action: {
                viewModel.showErrorAlert = false
                router.popToRoot()
            })
        } message: {
            Text(viewModel.messageError)
        }
        .padding()
        .navigationTitle("Clima actual")
        .onAppear {
            viewModel.getCurrentWeather()
        }
    }

  

}



#Preview {
    WeatherCurrentView()
}
