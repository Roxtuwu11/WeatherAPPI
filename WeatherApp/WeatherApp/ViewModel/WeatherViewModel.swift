//
//  WeatherViewModeñ.swift
//  WeatherApp
//
//  Created by Ximena Rotceh Mendoza Gamino on 14/05/25.
//

import Foundation
import Observation
import CoreData
import UIKit

class WeatherViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var showErrorAlert = false
    @Published var messageError = ""
    @Published var currentWeather: WeatherData?
    @Published var historicalWeather: WeatherData?
    @Published var city: City?
    private let service = WeatherService()
   
   

    var latestTemperature: Double? {
        historicalWeather?.hourly?.temperature2M.last
       }

       var minTemperature: Double? {
           historicalWeather?.hourly?.temperature2M.min()
       }

       var maxTemperature: Double? {
           historicalWeather?.hourly?.temperature2M.max()
       }

       var latestHumidity: Double? {
           historicalWeather?.hourly?.temperature2M.last
       }

       var latestWind: Double? {
           historicalWeather?.hourly?.temperature2M.last
       }

       var temperatureUnit: String {
           historicalWeather?.hourlyUnits?.temperature2M ?? "°C"
       }

       var humidityUnit: String {
           historicalWeather?.hourlyUnits?.relativeHumidity2M ?? "%"
       }

       var windUnit: String {
           historicalWeather?.hourlyUnits?.windSpeed10M ?? "km/h"
       }
    func formatted(_ value: Double?, unit: String) -> String {
        guard let value = value else { return "--" }
        return String(format: "%.1f %@", value, unit)
    }
    func connectBD() -> NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    
    func saveCity(cityName: String)
    {
        let context = connectBD()
        let entityCity = NSEntityDescription.insertNewObject(
            forEntityName: "City",
            into: context
        ) as! City
        entityCity.cityName = cityName
        
        do {
            try context.save()
            print("Se guardo a la persona")
        } catch let error as NSError {
            print("Error al guardar: \(error.localizedDescription)")
        }
    }
    
    func showCities() -> [City] {
        let context = connectBD()
        var city = [City]()
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        do {
            city = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Error al guardar: \(error.localizedDescription)")
        }
        return city
    }
    
    func deleteCities(city: City)
    {
        let context = connectBD()
        context.delete(city)
        do {
            try context.save()
        }
        catch let error as NSError {
            print("Error al guardar: \(error.localizedDescription)")
        }
    }
    private func fetchWeather(
        latitude: Float,
        longitude: Float,
        pastDays: Int? = nil,
        hourly: String? = nil,
        currentWeather: Bool = false,
        onSuccess: @escaping (WeatherData) -> Void
    ) {
        let request = RequestWeather(
            latitude: latitude,
            longitude: longitude,
            pastDays: pastDays, hourly: hourly, currentWeather: currentWeather
        )
        
        service.fetchWeather(request: request) { result in
            guard let weather = result else { return }
            onSuccess(weather)
        } onFailure: { error in
            self.presentError(error: error)
        }
    }

    func getCurrentWeather() {
        resolveCoordinates { lat, lon in
            self.fetchWeather(latitude: lat, longitude: lon, currentWeather: true) { weather in
                self.currentWeather = weather
            }
        }
    }
    
    func getHistoricalWeather() {
        resolveCoordinates { lat, lon in
            self.fetchWeather(
                latitude: lat,
                longitude: lon,
                pastDays: 10,
                hourly: Constants.hourlyParameters.joined(separator: ",")
            ) { weather in
                self.historicalWeather = weather
            }
        }
    }

    
    private func resolveCoordinates(completion: @escaping (_ latitude: Float, _ longitude: Float) -> Void) {
        guard let cityName = city?.cityName else {
            presentError(error: ErrorServices__s.communication)
            return
        }

        let request = RequestCoordinates(name: cityName, count: 1)
        
        service.fetchCoordinates(request: request) { [self] result in
            guard let coordinate = result?.results,
                  let lat = coordinate.first?.latitude,
                  let lon = coordinate.first?.longitude else {
                      presentError(error: ErrorServices__s.communication)
                return
            }
            completion(lat, lon)
        } onFailure: { error in
            self.presentError(error: error)
        }
    }

    
    func description(for code: Int) -> String {
        switch code {
        case 0: return "Despejado"
        case 1, 2, 3: return "Parcialmente nublado"
        case 45, 48: return "Niebla"
        case 51, 53, 55: return "Llovizna"
        case 61, 63, 65: return "Lluvia"
        default: return "Clima desconocido"
        }
    }
    func presentError(error: Error?) {
        self.isLoading = false
        guard let err = error else { return  }
        self.showErrorAlert = true
        self.messageError =  err.localizedDescription
        
    }
    
}
