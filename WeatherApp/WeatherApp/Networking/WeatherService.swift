//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Ximena Rotceh Mendoza Gamino on 15/05/25.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(
        request: RequestWeather?,
        onSuccess: @escaping (WeatherData?) -> Void,
        onFailure: @escaping (Error?) -> Void
    )
    func fetchCoordinates(
        request: RequestCoordinates?,
        onSuccess: @escaping (CityModel?) -> Void,
        onFailure: @escaping (Error?) -> Void
    )

}

struct WeatherService: WeatherServiceProtocol {
    func fetchCoordinates(
        request: RequestCoordinates? ,
        onSuccess success:@escaping(
            (_ result: CityModel?)-> Void
        ),
                onFailure failure:@escaping((_ error:Error?)->Void)
)
    {
        guard let req = request else { return }
        let url = URL(string: URLConstants.coordinatesEndPoint)!
        APIClient.shared
            .getRequest(
                url: url,
                request: req,
                responseType: CityModel.self) { (result) in
                    success(result)
                } onFailure: { error in
                    failure(error)
                }
        
    }

    
  
    func fetchWeather(
        request: RequestWeather? ,
        onSuccess success:@escaping(
            (_ result: WeatherData?)-> Void
        ),
                onFailure failure:@escaping((_ error:Error?)->Void)
) {
        guard let req = request else { return }
        let url = URL(string: URLConstants.weatherEndPoint)!
        APIClient.shared
            .getRequest(
                url: url,
                request: req,
                responseType: WeatherData.self) { (result) in
                    success(result)
                } onFailure: { error in
                    failure(error)
                }

    }
}
