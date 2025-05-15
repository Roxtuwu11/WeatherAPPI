//
//  Route.swift
//  WeatherApp
//
//  Created by Ximena Rotceh Mendoza Gamino on 15/05/25.
//

import Foundation
import SwiftUI
weak var viewController: SearchViewController?

@Observable
class Router{
    var routes: [Route] = []
    func navigateToResult()
    {
        let uiHost = UIHostingController(rootView: WeatherCurrentView())
         
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
    case result
    case detail
    
}

