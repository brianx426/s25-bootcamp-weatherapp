//
//  WeeklyForecastView.swift
//  weatherapp
//
//  Created by Brian Liu on 2/15/25.
//

import SwiftUI

struct WeeklyForecastView: View {
    var day: String
    var weather: String
    var minTemp: String
    var maxTemp: String
    var absMin: Int
    var absMax: Int
    
    var body: some View {
        
        HStack(spacing: 30) {
            Text("\(day)")
                .foregroundStyle(.white)
                .frame(width: 60, height: 30, alignment: .leading)

                
            Image(systemName: weather)
                .foregroundStyle(weatherColor1, weatherColor2)
                .frame(width: 30, height: 30)

            TempBarView(absMin: absMin, absMax: absMax, min: Int(minTemp)!, max: Int(maxTemp)!)
        }
        .padding(.leading, 5)
        .padding(.trailing)

    }
    
    var weatherColor1: Color {
        switch weather {
        case "sun.max.fill": return .yellow
        default: return .white
        }
    }
    
    var weatherColor2: Color {
        switch weather {
        case "cloud.sun.fill": return .yellow
        case "cloud.rain.fill": return .blue
        case "cloud.drizzle.fill": return .blue
        case "cloud.bolt.rain.fill": return .blue
        case "sunrise.fill": return .yellow
        case "sunset.fill": return .yellow
        default: return weatherColor1
        }
    }
    
}

#Preview {
    WeeklyForecastView(day: "Today", weather: "moon.stars.fill", minTemp: "-3", maxTemp: "20", absMin: -10, absMax: 30)
}
