//
//  SunView.swift
//  weatherapp
//
//  Created by Brian Liu on 2/16/25.
//

import SwiftUI

struct TempBarView: View {
    var absMin: Int
    var absMax: Int
    var min: Int
    var max: Int
    
    
    var body: some View {
        HStack {
            Text("\(min)°")
                .foregroundStyle(.white)
                .frame(width: 40)
            
            GeometryReader { geometry in
                
                let totalRange = CGFloat(absMax - absMin)
                
                let lowPosition = CGFloat(min - absMin) / totalRange
                let highPosition = CGFloat(max - absMin) / totalRange

                
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.blue.opacity(0.3))
                        .frame(height: 6)
                    Capsule()
                        .fill(Color.blue)
                        .frame(width: (highPosition - lowPosition) * geometry.size.width, height: 6)
                        .offset(x: lowPosition * geometry.size.width)
                }
            }
            .frame(width: 100, height: 6)
            Text("\(max)°")
                .foregroundStyle(.white)
                .frame(width: 40)
        }
    }
}

#Preview {
    TempBarView(absMin: 0, absMax: 30, min: 4, max: 20)
}
