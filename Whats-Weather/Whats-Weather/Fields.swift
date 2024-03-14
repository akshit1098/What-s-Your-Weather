//
//  Fields.swift
//  Whats-Weather
//
//  Created by Akshit Saxena on 3/8/24.
//



//Link:- https://openweathermap.org/forecast5
import Foundation


struct WeatherResponse: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [WeatherPrediction]
    let city: CityDescription
}

struct WeatherPrediction: Codable {
    let dt: Int
    let main: WeatherDetails
    let weather: [WeatherCondition]
    let clouds: Cloudiness
    let wind: WindDescription
    let visibility: Int
    let pop: Double
    let rain: [String: Double]?
    let snow: [String: Double]?
    let sys: PartOfDay
    let dt_txt: String
}

struct WeatherDetails: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Double
    let grnd_level: Double
    let humidity: Int
    let temp_kf: Double 
}

struct WeatherCondition: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

//struct Precipitation: Codable {
//    let volume: Double // This represents the volume of precipitation
//
//    private enum CodingKeys: String, CodingKey {
//        case volume = "3h"
//    } // Changed property name to `3h` to match API response
//}

struct Cloudiness: Codable {
    let all: Int
}

struct WindDescription: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct PartOfDay: Codable {
    let pod: String
}

struct CityDescription: Codable {
    let id: Int
    let name: String
    let coord: Location
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

struct Location: Codable {
    let lat: Double
    let lon: Double
}

