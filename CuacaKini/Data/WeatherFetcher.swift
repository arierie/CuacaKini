//
//  OpenWeatherAPI.swift
//  CuacaKini
//
//  Created by Arie on 24/12/19.
//  Copyright © 2019 Arie. All rights reserved.
//

import Foundation
import Combine

class WeatherFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

private extension WeatherFetcher {
    struct OpenWeatherMapAPI {
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let path = "/data/2.5"
        static let imageBaseUrl = "http://openweathermap.org"
        static let imagePath = "/img/wn/"
        static let imageDimension = "@2x.png"
    }
    
    func makeImageUrl(icon: String) -> String {
        return OpenWeatherMapAPI.imageBaseUrl + OpenWeatherMapAPI.imagePath + icon + OpenWeatherMapAPI.imageDimension
    }
    
    func makeWeeklyForecastComponents(
        withCity city: String
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherMapAPI.scheme
        components.host = OpenWeatherMapAPI.host
        components.path = OpenWeatherMapAPI.path + "/forecast"
        
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: openWeatherMapApiKey)
        ]
        
        return components
    }
    
    func makeCurrentForecastComponents(
        withCity city: String
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherMapAPI.scheme
        components.host = OpenWeatherMapAPI.host
        components.path = OpenWeatherMapAPI.path + "/weather"
        
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "mode", value: "json"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "APPID", value: openWeatherMapApiKey)
        ]
        
        return components
    }
}

protocol WeatherFetchable {
    func imageUrl(icon: String) -> String
    
    func weeklyWeatherForecast(
        forCity city: String
    ) -> AnyPublisher<WeeklyForecastResponse, WeatherError>
    
    func currentWeatherForecast(
        forCity city: String
    ) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError>
}

extension WeatherFetcher: WeatherFetchable {
    func imageUrl(icon: String) -> String {
        return makeImageUrl(icon: icon)
    }
    
    func weeklyWeatherForecast(
        forCity city: String
    ) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
        return forecast(with: makeWeeklyForecastComponents(withCity: city))
    }
    
    func currentWeatherForecast(
        forCity city: String
    ) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError> {
        return forecast(with: makeCurrentForecastComponents(withCity: city))
    }
    
    private func forecast<T>(
        with components: URLComponents
    ) -> AnyPublisher<T, WeatherError> where T: Decodable {
        guard let url = components.url else {
            let error = WeatherError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
        }
        .eraseToAnyPublisher()
    }
}
