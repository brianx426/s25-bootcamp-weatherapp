//
//  ContentView.swift
//  weatherapp
//
//  Created by Brian Liu on 2/15/25.
//

import SwiftUI

struct ContentView: View {
    var city: String
    var startTemp: String
    var startHour: String
    var startIcon: String
    
    var body: some View {
        let times = makeTimes(start: Int(startHour) ?? 0)
        let temps = makeTemps(base: Int(startTemp) ?? 0, times: times)
        let icons = makeIcons(icon: startIcon, times: times, temps: temps)
        let min = findMin(from: temps)
        let max = findMax(from: temps)
        let days = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"]
        let sunnyGradient = LinearGradient(colors: [Color("Sunny1"), Color("Sunny2"), Color("Sunny3")], startPoint: .top, endPoint: .bottom)
        let cloudyDayGradient = LinearGradient(colors: [Color("Cloudy1"), Color("Cloudy2"), Color("Cloudy3")], startPoint: .top, endPoint: .bottom)
        let nightGradient = LinearGradient(colors: [Color("Night1"), Color("Night2"), Color("Night3")], startPoint: .top, endPoint: .bottom)
        let rainDayGradient = LinearGradient(colors: [Color("RainDay1"), Color("RainDay2"), Color("RainDay3")], startPoint: .top, endPoint: .bottom)
        let rainNightGradient = LinearGradient(colors: [Color("RainNight1"), Color("RainNight2"), Color("RainNight3")], startPoint: .top, endPoint: .bottom)
        let snowDayGradient = LinearGradient(colors: [Color("SnowDay1"), Color("SnowDay2"), Color("SnowDay3")], startPoint: .top, endPoint: .bottom)
        let snowNightGradient = LinearGradient(colors: [Color("SnowNight1"), Color("SnowNight2"), Color("SnowNight3")], startPoint: .top, endPoint: .bottom)
        
        let prec: [String] = ["cloud.drizzle.fill", "cloud.rain.fill", "cloud.bolt.rain.fill"]
        
        ZStack {
            let isDaytime = isDay(time: startHour)

            let backgroundGradient: LinearGradient = {
                switch startIcon {
                case "snowflake":
                    return isDaytime ? snowDayGradient : snowNightGradient
                case "cloud.fill":
                    return isDaytime ? cloudyDayGradient : nightGradient
                case let icon where prec.contains(icon):
                    return isDaytime ? rainDayGradient : rainNightGradient
                default:
                    return isDaytime ? sunnyGradient : nightGradient
                }
            }()

            backgroundGradient.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 4) {
                    Text("\(city)")
                        .foregroundStyle(.white)
                        .font(.system(size: 40))
                    Text("\(startTemp)°")
                        .font(.system(size: 110, weight: .thin))
                        .foregroundStyle(.white)
                    Text("\(iconToWeather(icon: startIcon))")
                        .foregroundStyle(.white)
                        .font(.system(size: 30))
                    HStack {
                        Text("H:\(max)°")
                            .foregroundStyle(.white)
                        Text("L:\(min)°")
                            .foregroundStyle(.white)
                    }
                    .font(.title)
                    
                }
                HourlyRowView(temps: temps, times: times, icons: icons)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom)
                    .frame(width: 445)
                    
                
                WeeklyRowView(startDay: days.randomElement()!, lowTemp: min, highTemp: max, weather: icons[0], absMin: Int.random(in: -20...(Int(min) ?? 0)), absMax: Int.random(in: (Int(max) ?? 20)...35))
                    .padding(.leading)
                    .padding(.trailing)

                    .frame(width:  400)
            }
            .padding(.leading)
            .padding(.trailing)
        }
    }
    
    func makeTimes(start: Int) -> Array<String> {
        var time = start
        var times = Array(repeating: "", count: 26)
        times[0] = "Now"
        for i in 1..<26 {
            if times[i - 1] == "07" {
                let minInt = Int.random(in: 0...59)
                let minStr = minInt < 10 ? "0\(minInt)" : "\(minInt)"
                times[i] = "07:\(minStr)"
            } else if times[i - 1] == "18" {
                let minInt = Int.random(in: 0...59)
                let minStr = minInt < 10 ? "0\(minInt)" : "\(minInt)"
                times[i] = "18:\(minStr)"
            } else {
                time = (time + 1) % 24
                times[i] = time < 10 ? "0\(time)" : "\(time)"
            }
        }
        return times
    }
    
    func makeTemps(base: Int, times: Array<String>) -> Array<String> {
        var temp = base
        var temps = Array(repeating: "", count: 26)
        temps[0] = "\(temp)"
        for i in 1..<26 {
            temp += Int.random(in: -3...3)
            if times[i].count == 5 && times[i - 1] == "07" {
                temps[i] = "Sunrise"
            } else if times[i].count == 5 && times[i - 1] == "18" {
                temps[i] = "Sunset"
            } else {
                temps[i] = "\(temp)"
            }
        }
        return temps
    }
    
    func makeIcons(icon: String, times: Array<String>, temps: Array<String>) -> Array<String> {
        
        var icons = Array(repeating: "", count: 26)
        icons[0] = icon
        
        for i in 1..<26 {
            icons[i] = determineNextIcon(prevIcon: times[i - 1].count == 5 ? icons[i - 2] : icons[i - 1], hour: times[i], temp: temps[i])
        }
        return icons
    }
    
    func determineNextIcon(prevIcon: String, hour: String, temp: String) -> String {
        let daySafe: [String] = ["sun.max.fill", "cloud.sun.fill", "cloud.fill"]
        let nightSafe: [String] = ["moon.fill", "cloud.moon.fill", "moon.stars.fill", "cloud.fill"]
        let prec: [String] = ["cloud.drizzle.fill", "cloud.rain.fill", "cloud.bolt.rain.fill"]
        
        if hour.count == 5 {
            if hour.starts(with: "07") {
                return "sunrise.fill"
            } else {
                return "sunset.fill"
            }
        }
        
        let hourInt: Int = Int(hour) ?? -9999
        let tempInt: Int = Int(temp) ?? -9999
        
        if prec.contains(prevIcon) {
            let continuePrec = Int.random(in: 0...100) < 50
            if continuePrec {
                return prec.randomElement()!
            } else {
                return "cloud.fill"
            }
        } else if prevIcon == "wind" {
            let continueWind = Int.random(in: 0...100) < 50
            if continueWind {
                return "wind"
            } else {
                return "cloud.fill"
            }
        } else if daySafe.contains(prevIcon) {
            if hourInt <= 18 && hourInt > 7 {
                let startPrec = Int.random(in: 0...100) < 15
                if startPrec {
                    return prec.randomElement()!
                } else {
                    return daySafe.randomElement()!
                }
            } else {
                return nightSafe.randomElement()!
            }
        } else if nightSafe.contains(prevIcon) {
            if hourInt <= 7 || hourInt > 18 {
                let startPrec = Int.random(in: 0...100) < 15
                if startPrec {
                    return prec.randomElement()!
                } else {
                    return nightSafe.randomElement()!
                }
            } else {
                return daySafe.randomElement()!
            }
        } else if prevIcon == "snowflake" && tempInt <= 0 {
            let continueSnow = Int.random(in: 0...100) < 50
            if continueSnow {
                return "snowflake"
            } else {
                return ["cloud.fill", "wind"].randomElement()!
            }
        }
        return ""
    }
    
    func findMin(from array: [String]) -> String {
        var min = Int(array[1])!
        for i in 0..<array.count {
            if array[i] == "Sunrise" || array[i] == "Sunset" {
                continue
            } else {
                if Int(array[i])! < min {
                    min = Int(array[i])!
                }
            }
        }
        return String(min)
    }
    
    func findMax(from array: [String]) -> String {
        var max = Int(array[1])!
        for i in 0..<array.count {
            if array[i] == "Sunrise" || array[i] == "Sunset" {
                continue
            } else {
                if Int(array[i])! > max {
                    max = Int(array[i])!
                }
            }
        }
        return String(max)
    }
    
    func iconToWeather(icon: String) -> String {
        switch icon {
        case "cloud.fill":
            return "Cloudy"
        case "moon.fill":
            return "Clear"
        case "sun.max.fill":
            return "Sunny"
        case "snowflake":
            return "Snow"
        case "cloud.sun.fill":
            return "Partly Cloudy"
        case "cloud.moon.fill":
            return "Partly Cloudy"
        case "cloud.rain.fill":
            return "Rain"
        case "cloud.drizzle.fill":
            return "Drizzle"
        case "cloud.bolt.rain.fill":
            return "Thunderstorm"
        case "wind":
            return "Windy"
        case "moon.stars.fill":
            return "Mostly Clear"
        default:
            return "Unknown"
        }
    }
    
    func isDay(time: String) -> Bool {
        return Int(time)! <= 18 && Int(time)! > 7
    }
}

#Preview {
    // Comment out all but the one you want to see
//    ContentView(city: "Chapel Hill", startTemp: String(Int.random(in: -18...30)), startHour: String(Int.random(in: 0...23)), startIcon: "wind")
    
//    ContentView(city: "Chapel Hill", startTemp: String(Int.random(in: -18...30)), startHour: String(Int.random(in: 0...23)), startIcon: "cloud.drizzle.fill")
    
//    ContentView(city: "Chapel Hill", startTemp: String(Int.random(in: -18...30)), startHour: String(Int.random(in: 0...23)), startIcon: "cloud.rain.fill")
    
    ContentView(city: "Chapel Hill", startTemp: String(Int.random(in: -18...30)), startHour: String(Int.random(in: 0...23)), startIcon: "cloud.bolt.rain.fill")
    
//    ContentView(city: "Chapel Hill", startTemp: String(Int.random(in: -18...30)), startHour: String((Int.random(in:8...18) + 12) % 24), startIcon: "moon.stars.fill")
    
//    ContentView(city: "Chapel Hill", startTemp: String(Int.random(in: -18...30)), startHour: String(Int.random(in:8...18)), startIcon: "sun.max.fill")
    
//    ContentView(city: "Chapel Hill", startTemp: String(Int.random(in: -18...0)), startHour: String(Int.random(in: 0...23)), startIcon: "snowflake")
    
//    ContentView(city: "Chapel Hill", startTemp: String(Int.random(in: -18...30)), startHour: String(Int.random(in: 0...23)), startIcon: "cloud.fill")
    
}
