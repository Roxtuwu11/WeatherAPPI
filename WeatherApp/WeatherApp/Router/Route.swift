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
    func navigateToResult()
    {
        let uiHost = UIHostingController(rootView: WeatherCurrentView())
         
         viewController?.navigationController?.pushViewController(uiHost,
                                                                       animated: true)
    }
}

