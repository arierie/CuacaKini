//
//  DailyWeatherRowView.swift
//  CuacaKini
//
//  Created by Arie on 24/12/19.
//  Copyright © 2019 Arie. All rights reserved.
//

import SwiftUI

struct DailyWeatherRowView: View {
    private let viewModel: DailyWeatherRowViewModel
    
    init(viewModel: DailyWeatherRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color.init(hex: "FFC202"))
                Text("\(viewModel.day)")
                .font(.title)
            }
            
            VStack(alignment: .leading) {
                Text("\(viewModel.title)")
                    .font(.body)
                Text("\(viewModel.fullDescription)")
                    .font(.footnote)
            }
            .padding(.leading, 8)
            
            Spacer()
            
            Text("\(viewModel.temperature)°")
                .font(.title)
        }
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
    }
}
