//
//  Route.swift
//  WeatherApp
//
//  Created by Ximena Rotceh Mendoza Gamino on 15/05/25.
//

import Foundation
import SwiftUI



class Router: ObservableObject{
    weak var viewController: SearchViewController?
    @Published  var routes: [Route] = []
    func navigateToCurrentWeather(viewModel: WeatherViewModel)
    {
        let uiHost = UIHostingController(rootView:
                                           
            WeatherRootView()
            .environmentObject(viewModel).environmentObject(self) )
            
         viewController?.navigationController?.pushViewController(uiHost,
                                                                       animated: true)
    }
    func navigateTo(route: Route) {
        routes.append(route)
    }
    func unwind(_ route: Route)
    {
        guard let index = routes.firstIndex(where: { $0 == route }) else { return  }
        routes = Array(routes.prefix(upTo: index + 1))
    }
    func popToRoot()
    {
        routes = []
    }
    
}

enum Route: Hashable {

    case detail
    
}

