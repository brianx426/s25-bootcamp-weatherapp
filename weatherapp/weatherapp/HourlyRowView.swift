//
//  HourlyRowView.swift
//  weatherapp
//
//  Created by Brian Liu on 2/15/25.
//

import SwiftUI

struct HourlyRowView: View {
    var temps: Array<String>
    var times: Array<String>
    var icons: Array<String>
    
    var body: some View {
        let prec: [String] = ["cloud.drizzle.fill", "cloud.rain.fill", "cloud.bolt.rain.fill", "snowflake"]

        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Image(systemName: "clock")
                    .foregroundColor(.white)
                Text("HOURLY FORECAST")
                    .foregroundColor(.white)
            }
            .padding(.leading)
            .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<26, id: \.self) {hour in
                        let time = times[hour]
                        let temp = temps[hour]
                        let icon = icons[hour]
                        let a = Int.random(in:1...105)
                        HourlyForecastView(time: time, temp: temp, icon: icon, prec: prec.contains(icon) ? abs((a % 5) + (5 - a)) : 0)
                    }
                }
            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
            
        }
        .background(.ultraThinMaterial.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.leading)
        .padding(.trailing)
        
    }
}

#Preview {
    HourlyRowView(temps: ["5", "6", "5", "4", "1", "0", "3", "Sunset", "6", "4", "2", "1", "2", "1", "-2", "0", "3", "1", "2", "1", "3", "Sunrise", "7", "10", "12", "14"], times: ["Now", "13", "14", "15", "16", "17", "18", "18:25", "19", "20", "21", "22", "23", "00", "01", "02", "03", "04", "05", "06", "07", "07:13", "08", "09", "10", "11"], icons: ["sun.max.fill", "cloud.sun.fill", "sun.max.fill", "cloud.sun.fill", "sun.max.fill", "cloud.sun.fill", "sun.max.fill", "sunset.fill", "moon.stars.fill", "cloud.fill", "moon.stars.fill", "cloud.drizzle.fill", "cloud.fill", "cloud.fill", "moon.fill", "cloud.fill", "moon.stars.fill", "cloud.moon.fill", "moon.stars.fill", "cloud.moon.fill", "cloud.fill", "sunrise.fill", "cloud.sun.fill", "sun.max.fill", "sun.max.fill", "cloud.sun.fill"])
}

