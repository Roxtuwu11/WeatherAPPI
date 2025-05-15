//
//  Weather.swift
//  WeatherApp
//
//  Created by Ximena Rotceh Mendoza Gamino on 14/05/25.
//

import Foundation


struct City: Codable {
    var id = UUID()
    let name: String
    let coordinates: String
}

struct WeatherData: Identifiable {
    let id = UUID()
    let cityName: String
    let temperature: Double
    let description: String
    let minTemp: Double
    let maxTemp: Double
    let humidity: Int
    let windSpeed: Double
}
