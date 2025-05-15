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
@Observable
class WeatherViewModel {
    var isLoading = true
    var showErrorAlert = false
    var messageError = ""
    var currentWeather: WeatherData?
    var historicalWeather: WeatherData?
    private let service = WeatherService()
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
    func getCurrentWeather(latitude: Float, longitude: Float)
    {
        
        let request = RequestWeather(
            latitude: latitude,
            longitude: longitude,currentWeather: true
           
        )
        
        service.fetchWeather(request: request) { result in
            guard let currentWeather = result else {return }
            self.currentWeather = currentWeather
        } onFailure: { error in
            self.presentError(error: error)
        }

    }
    
    func getHistoricalWeather(latitude: Float, longitude: Float)
    {
       
        let request = RequestWeather(
            latitude: latitude,
            longitude: longitude,pastDays: 10, hourly: ["temperature_2m","relative_humidity_2m","wind_speed_10m"]
           
        )
        
        service.fetchWeather(request: request) { result in
            guard let currentWeather = result else {return }
            self.historicalWeather = currentWeather
        } onFailure: { error in
            self.presentError(error: error)
        }

    }
    func getCoordinates(of city: String)
    {
        let request = RequestCoordinates(name: city, count: 1)
        
        service.fetchCoordinates(request: request) { result in
            
        } onFailure: { error in
            self.presentError(error: error)
        }

    }
    func presentError(error: Error?) {
        self.isLoading = false
        guard let err = error else { return  }
        self.showErrorAlert = true
        self.messageError =  err.localizedDescription
        
    }
    
}
