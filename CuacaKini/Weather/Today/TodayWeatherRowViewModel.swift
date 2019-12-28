//
//  TodayRowViewModel.swift
//  CuacaKini
//
//  Created by Arie Ridwan on 27/12/19.
//  Copyright © 2019 Arie. All rights reserved.
//

import Foundation
import SwiftUI

struct TodayWeatherRowViewModel {
    private let weatherFetcher: WeatherFetchable
    private let response: CurrentWeatherForecastResponse
    
    var temperature: String {
        return "\(response.main.temperature)°"
    }
    
    var title: String {
        guard let title = response.weather.first?.main.rawValue else { return "" }
        return title
    }
    
    var fullDescription: String {
        guard let description = response.weather.first?.description else { return "" }
        return description
    }
    
    var imageUrl: String {
        guard let icon = response.weather.first?.icon else { return "" }
        return weatherFetcher.imageUrl(icon: icon)
    }
    
    init(weatherFetcher: WeatherFetchable, response: CurrentWeatherForecastResponse) {
        self.weatherFetcher = weatherFetcher
        self.response = response
    }
}
