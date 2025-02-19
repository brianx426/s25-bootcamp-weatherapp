//
//  HourlyForecastView.swift
//  weatherapp
//
//  Created by Brian Liu on 2/15/25.
//

import SwiftUI

struct HourlyForecastView: View {
    var time: String
    var temp: String
    var icon: String
    var prec: Int
    
    
    var body: some View {
        
        
        VStack(spacing: 7) {
            Text(time)
                .foregroundColor(Color.white)
                .frame(height: 20)
                .padding(.bottom, (prec == 0) ? 0 : -5)
            if prec == 0 {
                Image(systemName: icon)
                    .foregroundStyle(weatherColor1, weatherColor2)
                    .frame(width: 30, height: 30)
            } else {
                VStack(spacing: -5) {
                    Image(systemName: icon)
                        .foregroundStyle(weatherColor1, weatherColor2)
                        .frame(width: 30, height: 30)
                    Text("\(prec)%")
                        .foregroundColor(Color("PrecipitationColor"))
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.bottom, -5)
                }
            }
            Text(temp == "Sunrise" || temp == "Sunset" ? "\(temp)" : "\(temp)°")
                .foregroundColor(Color.white)
                .frame(height: 20)
                
        }
//        .background(Color.black)
    }
    
    var weatherColor1: Color {
        switch icon {
        case "sun.max.fill": return .yellow
        default: return .white
        }
    }
    
    var weatherColor2: Color {
        switch icon {
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
    HourlyForecastView(time: "07:24", temp: "Sunrise", icon: "sunrise.fill", prec: 0)
}
