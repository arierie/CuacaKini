//
//  WeeklyWeatherView.swift
//  CuacaKini
//
//  Created by Arie on 24/12/19.
//  Copyright © 2019 Arie. All rights reserved.
//

import SwiftUI

struct WeeklyWeatherView: View {
    @ObservedObject var viewModel: WeeklyWeatherViewModel
    
    init(viewModel: WeeklyWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading) {
                    searchFieldSection
                    if viewModel.dailyWeather.isEmpty {
                        emptySection
                    } else {
                        if viewModel.todayWeather != nil {
                            Text("Today")
                                .font(.custom("SF Pro", size: 24))
                                .bold()
                                .foregroundColor(.black)
                                .padding(.top, 16)
                                .padding(.bottom, 8)
                                .padding(.horizontal, 4)
                            TodayWeatherRowView.init(viewModel: viewModel.todayWeather)
                        }
                        Text("This week")
                            .font(.custom("SF Pro", size: 24))
                            .bold()
                            .foregroundColor(.black)
                            .padding(.top, 16)
                            .padding(.horizontal, 4)
                        forecastSection
                    }
                }
                .listRowInsets(EdgeInsets())
                .padding(.horizontal, 8)
                .padding(.top, 12)
                .navigationBarTitle("Forecast")
                .navigationBarItems(
                    leading:
                    Text("Holla, Arie"),
                    trailing:
                    Circle()
                        .foregroundColor(.yellow)
                        .frame(width: 32, height: 32, alignment: .center)
                )
            }
            .listSeparatorStyleNone()
        }
    }
}

private extension WeeklyWeatherView {
    var searchFieldSection: some View {
        HStack(spacing: 16) {
            Button(action: {
                self.viewModel.fetchData()
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(hex: "9B9DA0"))
            }
            TextField("Search", text: $viewModel.city)
                .foregroundColor(Color(hex: "9B9DA0"))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 24, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(hex: "E5E7EA"))
        .cornerRadius(12)
    }
    
    var forecastSection: some View {
        ForEach(viewModel.dailyWeather, content: DailyWeatherRowView.init(viewModel:))
    }
    
    var emptySection: some View {
        VStack(alignment: .center, spacing: 16) {
            Image(systemName: "wind")
                .resizable()
                .frame(width: 56, height: 56, alignment: .center)
                .foregroundColor(Color(hex: "9B9DA0"))
            Text("Oops, we couldn't find the data")
                .lineLimit(nil)
                .foregroundColor(Color(hex: "9B9DA0"))
                .font(.headline)
            Text("Please try again next time!")
                .lineLimit(nil)
                .foregroundColor(Color(hex: "9B9DA0"))
                .font(.subheadline)
            Button(action: {
                self.viewModel.fetchData()
            }) {
                Text("Retry")
                    .foregroundColor(Color(hex: "FFC202"))
                    .font(.body)
                    .bold()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .padding([.vertical, .horizontal], 16)
    }
}
