//
//  Weather.swift
//  WeatherApp
//
//  Created by Ximena Rotceh Mendoza Gamino on 14/05/25.
//

import Foundation

struct RequestWeather: Codable {
    let latitude: Float?
    let longitude: Float?
    let pastDays: Int?
    let hourly: [String]?
    let currentWeather: Bool?
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude, hourly
        case pastDays = "past_days"
        case currentWeather = "current_weather"
    }
    init(
        latitude: Float? = nil,
        longitude: Float? = nil,
        pastDays: Int? = nil,
        hourly: [String]? = nil, currentWeather:Bool? = nil
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.pastDays = pastDays
        self.hourly = hourly
        self.currentWeather = currentWeather
    }
}


struct WeatherData: Codable,Equatable, Hashable{


    let latitude, longitude, generationtimeMS: Double?
    let utcOffsetSeconds: Int?
    let timezone, timezoneAbbreviation: String?
    let elevation: Int?
    let currentWeatherUnits: CurrentWeatherUnits?
    let currentWeather: CurrentWeather?
    let hourlyUnits: HourlyUnits?
    let hourly: Hourly?

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentWeatherUnits = "current_weather_units"
        case currentWeather = "current_weather"
        case hourlyUnits = "hourly_units"
        case hourly
    }
}

// MARK: - CurrentWeather
struct CurrentWeather: Codable, Equatable, Hashable {
    let time: String
    let interval: Int
    let temperature, windspeed: Double
    let winddirection, isDay, weathercode: Int

    enum CodingKeys: String, CodingKey {
        case time, interval, temperature, windspeed, winddirection
        case isDay = "is_day"
        case weathercode
    }
}

// MARK: - CurrentWeatherUnits
struct CurrentWeatherUnits: Codable, Equatable, Hashable {
    let time, interval, temperature, windspeed: String
    let winddirection, isDay, weathercode: String

    enum CodingKeys: String, CodingKey {
        case time, interval, temperature, windspeed, winddirection
        case isDay = "is_day"
        case weathercode
    }
}

struct Hourly: Codable, Equatable, Hashable {
    let time: [String]
    let temperature2M: [Double]
    let relativeHumidity2M: [Int]
    let windSpeed10M: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case windSpeed10M = "wind_speed_10m"
    }
}

// MARK: - HourlyUnits
struct HourlyUnits: Codable, Equatable, Hashable {
    let time, temperature2M, relativeHumidity2M, windSpeed10M: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case windSpeed10M = "wind_speed_10m"
    }
}

struct RequestCoordinates: Codable {
    let name: String
    let count: Int
}


struct CityModel: Codable {
    let results: [Result]
    let generationtimeMS: Double

    enum CodingKeys: String, CodingKey {
        case results
        case generationtimeMS = "generationtime_ms"
    }
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name: String
    let latitude, longitude, elevation: Int
    let featureCode, countryCode: String
    let population, countryID: Int
    let country: String

    enum CodingKeys: String, CodingKey {
        case id, name, latitude, longitude, elevation
        case featureCode = "feature_code"
        case countryCode = "country_code"
        case population
        case countryID = "country_id"
        case country
    }
}
