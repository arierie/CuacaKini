//
//  WeeklyWeatherViewModel.swift
//  CuacaKini
//
//  Created by Arie on 24/12/19.
//  Copyright © 2019 Arie. All rights reserved.
//

import Foundation
import Combine

class WeeklyWeatherViewModel: ObservableObject, Identifiable {
    @Published var city: String = "London"
    
    @Published var dailyWeather: [DailyWeatherRowViewModel] = []
    
    @Published var todayWeather: TodayWeatherRowViewModel? = nil
    
    private let weatherFetcher: WeatherFetchable
    
    private var disposables = Set<AnyCancellable>()
    
    init(
        weatherFetcher: WeatherFetchable,
        scheduler: DispatchQueue = DispatchQueue(label: "WeeklyWeatherViewModel")
    ) {
        self.weatherFetcher = weatherFetcher
        self.fetchData()
    }
    
    func fetchData() {
        fetchWeather()
        fetchTodayWeather()
    }
    
    func fetchWeather() {
        weatherFetcher.weeklyWeatherForecast(forCity: city)
            .map { response in
                response.list.map(DailyWeatherRowViewModel.init)
        }
        .map { response in
            Array.removeDuplicates(response)
        }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.dailyWeather = []
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] forecast in
                guard let self = self else {
                    return
                }
                self.dailyWeather = forecast
        }).store(in: &disposables)
    }
    
    func fetchTodayWeather() {
        weatherFetcher.currentWeatherForecast(forCity: city)
            .map { response in
                TodayWeatherRowViewModel.init(weatherFetcher: self.weatherFetcher, response: response)
        }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.todayWeather = nil
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] forecast in
                guard self != nil else {
                    return
                }
                self?.todayWeather = forecast
        }).store(in: &disposables)
    }
}
