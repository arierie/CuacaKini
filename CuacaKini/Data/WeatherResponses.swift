//
//  WeatherResponses.swift
//  CuacaKini
//
//  Created by Arie on 24/12/19.
//  Copyright © 2019 Arie. All rights reserved.
//

import Foundation

struct WeeklyForecastResponse: Decodable {
    let list: [Item]
    
    struct Item: Codable {
        let date: Date
        let main: MainClass
        let weather: [Weather]
        
        enum CodingKeys: String, CodingKey {
            case date = "dt"
            case main
            case weather
        }
    }
    
    struct MainClass: Codable {
        let temp: Double
    }
    
    struct Weather: Codable {
        let main: MainEnum
        let description: String
    }
    
    enum MainEnum: String, Codable {
        case clear = "Clear"
        case clouds = "Clouds"
        case rain = "Rain"
    }
}

struct CurrentWeatherForecastResponse: Decodable {
    let coord: Coord
    let main: Main
    let weather: [Weather]
    
    struct Main: Codable {
        let temperature: Double
        let humidity: Int
        let maxTemperature: Double
        let minTemperature: Double
        
        enum CodingKeys: String, CodingKey {
            case temperature = "temp"
            case humidity
            case maxTemperature = "temp_max"
            case minTemperature = "temp_min"
        }
    }
    
    struct Weather: Codable {
        let main: MainEnum
        let description: String
        let icon: String
    }
    
    enum MainEnum: String, Codable {
        case clear = "Clear"
        case clouds = "Clouds"
        case rain = "Rain"
    }
    
    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
}
