//
//  SceneDelegate.swift
//  CuacaKini
//
//  Created by Arie on 24/12/19.
//  Copyright © 2019 Arie. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let fetcher = WeatherFetcher()
        let viewModel = WeeklyWeatherViewModel(weatherFetcher: fetcher)
        let weeklyView = WeeklyWeatherView(viewModel: viewModel)

        // Use a UIHostingController as window root view controller
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: weeklyView)
        window.makeKeyAndVisible()
        self.window = window
    }
}
