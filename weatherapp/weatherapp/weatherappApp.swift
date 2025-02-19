//
//  weatherappApp.swift
//  weatherapp
//
//  Created by Brian Liu on 2/15/25.
//

import SwiftUI

@main
struct weatherappApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView(city: "Chapel Hill", startTemp: "2", startHour: String(Int.random(in:0...23)), startIcon: "cloud.fill")
            ContentView(city: "Chapel Hill", startTemp: String(Int.random(in: -18...0)), startHour: String(Int.random(in: 0...23)), startIcon: "snowflake")
        }
    }
}
