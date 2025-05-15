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


}

struct WeatherService: WeatherServiceProtocol {
    
  
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
