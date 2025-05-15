//
//  APIClient.swift
//  WeatherApp
//
//  Created by Ximena Rotceh Mendoza Gamino on 15/05/25.
//

import Foundation
import Alamofire

public enum ErrorServices__s: Error {
    case nullResponse
    case noData
    case unknown
    case custom(reason: String)
    case deviceID
    case invalidSession
    case timeout
    case noInternet
    case communication
    case invalidModule(id: String)
}

class APIClient {
    static let shared = APIClient()
    var sessionManager: Session

    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        self.sessionManager = Session(configuration: configuration)
    }

    public func getRequest<T: Encodable, D: Decodable>(
        url: URL,
        request: T?,
        responseType: D.Type,
        onSuccess success: @escaping (D?) -> Void,
        onFailure failure: @escaping (Error) -> Void
    ) {
        DispatchQueue.global(qos: .background).async {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)

            if let req = request,
               let params = req.dictionary,
               !params.isEmpty {
                urlComponents?.queryItems = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            } else {
                urlComponents = URLComponents(string: url.absoluteString )
            }


            guard let finalURL = urlComponents?.url else {
                failure(ErrorServices__s.custom(reason: "URL inválida"))
                return
            }

            var urlRequest = URLRequest(url: finalURL)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            urlRequest.setValue("APP_USR-3980890892821190-041316-6a135b7bcd33f714823d5ef6c37ac6b5-290788001", forHTTPHeaderField: "Authorization")

            self.sessionManager.request(urlRequest).response { response in
                if let res = response.response {
                    print("respuesta: \(res) ")
                }
                if let error = response.error as NSError? {
                    switch error.code {
                    case NSURLErrorTimedOut:
                        failure(ErrorServices__s.timeout)
                    case NSURLErrorNotConnectedToInternet:
                        failure(ErrorServices__s.noInternet)
                    case NSURLErrorCancelled:
                        // Posible MITM o cierre manual
                        exit(0)
                    default:
                        failure(ErrorServices__s.communication)
                    }
                    return
                }

                guard let httpResponse = response.response else {
                    failure(ErrorServices__s.nullResponse)
                    return
                }

                guard let data = response.data else {
                    failure(ErrorServices__s.noData)
                    return
                }

               
                if (200...299).contains(httpResponse.statusCode) || httpResponse.statusCode == 400 || httpResponse.statusCode == 409 {
                    do {
                        let decoded = try JSONDecoder().decode(D.self, from: data)
                        print(decoded)
                        success(decoded)
                    } catch {
                        failure(ErrorServices__s.custom(reason: "Decoding error: \(error.localizedDescription)"))
                    }
                } else {
                    // Otro status code con posible body de error
                    do {
                        let decoded = try JSONDecoder().decode(D.self, from: data)
                        print(decoded)
                        success(decoded)
                    } catch {
                        failure(ErrorServices__s.communication)
                    }
                }
            }
        }
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any]
    }
}
