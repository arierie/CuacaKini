//
//  TodayWeatherRowView.swift
//  CuacaKini
//
//  Created by Arie Ridwan on 27/12/19.
//  Copyright © 2019 Arie. All rights reserved.
//

import Foundation
import SwiftUI

struct TodayWeatherRowView: View {
    private var viewModel: TodayWeatherRowViewModel? = nil
    
    init(viewModel: TodayWeatherRowViewModel?) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(viewModel?.title ?? "")")
                    .font(.body)
                    .bold()
                Text("\(viewModel?.fullDescription ?? "")")
                    .font(.body)
                    .foregroundColor(Color(hex: "9B9DA0"))
            }
            RemoteImageView(withURL: "\(viewModel?.imageUrl ?? "")")
                           .frame(width: 100, height: 100)
            Text("\(viewModel?.temperature ?? "")")
                .font(.largeTitle)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.init(hex: "FFFFFF"))
        .cornerRadius(8)
        .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.20), radius: 6, x: 0, y: 4)
    }
}
