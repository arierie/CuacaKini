//
//  WeatherError.swift
//  CuacaKini
//
//  Created by Arie on 24/12/19.
//  Copyright © 2019 Arie. All rights reserved.
//

import Foundation

enum WeatherError: Error {
  case parsing(description: String)
  case network(description: String)
}
