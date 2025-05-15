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
    
    func presentError(error: Error?) {
        self.isLoading = false
        guard let err = error else { return  }
        self.showErrorAlert = true
        self.messageError =  err.localizedDescription
        
    }
    
}
