//
//  RootView.swift
//  WeatherApp
//
//  Created by Ximena Rotceh Mendoza Gamino on 15/05/25.
//

import SwiftUI

struct WeatherRootView: View {
    @EnvironmentObject var viewModel: WeatherViewModel
    @EnvironmentObject var router: Router
    var body: some View {
        NavigationStack(path: $router.routes) {
            WeatherCurrentView()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .detail:
                        
                        WeatherDetailView()
               
                   
                    }
                }
        }.environmentObject(router)
    }
}



