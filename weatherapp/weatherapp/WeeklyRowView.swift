//
//  WeeklyRowView.swift
//  weatherapp
//
//  Created by Brian Liu on 2/15/25.
//

import SwiftUI

struct WeeklyRowView: View {
    var startDay: String
    var lowTemp: String
    var highTemp: String
    var weather: String
    var absMin: Int
    var absMax: Int
    
    var body: some View {
        let weathers = ["sun.max.fill", "cloud.sun.fill", "cloud.fill", "wind", "cloud.drizzle.fill", "cloud.rain.fill", "cloud.bolt.rain.fill", "snowflake"]
        
        let days = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"]
        
        let lows = makeLowTemps(min: absMin, max: absMax)
        let highs = makeHighTemps(lows: lows, min: absMin, max: absMax)
        let i: Int = days.firstIndex(of: startDay) ?? 0
        
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                    .foregroundStyle(.white)
                    
                Text("10-DAY FORECAST")
                    .foregroundStyle(.white)
            }
            .padding(.top)
            .padding(.leading)
            
            VStack(alignment: .leading) {
                ForEach(Array(0..<10), id: \.self) { (day: Int) in
                    if day == 0 {
                        WeeklyForecastView(day: "Today", weather: weather, minTemp: lowTemp, maxTemp: highTemp, absMin: absMin, absMax: absMax)
                            .padding(.leading)
                    } else {
                        let dayOfWeek = days[(i + day) % 7]
                        WeeklyForecastView(day: dayOfWeek, weather: Int(lows[day])! <= 0 ? weathers.randomElement()! : Array(weathers[0...weathers.count - 2]).randomElement()!, minTemp: lows[day], maxTemp: highs[day], absMin: absMin, absMax: absMax)
                            .padding(.leading)
                    }
                }
            }
        }
        .background(.ultraThinMaterial.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding(.leading)
        .padding(.trailing)
    }
    
    func makeLowTemps(min: Int, max: Int) -> Array<String> {
        var lows = Array(repeating: "", count: 10)
        for i in 1..<10 {
            lows[i] = "\(Int.random(in: min...max))"
        }
        return lows
    }
    
    func makeHighTemps(lows: Array<String>, min: Int, max: Int) -> Array<String> {
        var highs = Array(repeating:"", count: 10)
        
        for i in 1..<10 {
            let low = Int(lows[i]) ?? min
            highs[i] = "\(Int.random(in: low...max))"
        }
        return highs
    }
}

#Preview {
    WeeklyRowView(startDay: "Wed", lowTemp: "-5", highTemp: "9", weather: "snowflake", absMin: -6, absMax: 10)
}
