//
//  ContentView.swift
//  SwiftUICharts
//
//  Created by Swati Sharma
//

import SwiftUI

struct ChartExampleView: View {
    
    let weeklyDataPoints: [(String, Double)] = [
        ("9 Jul.", 5), ("10 Jul.", -1), ("11 Jul.", -10), ("12 Jul.", -4),
        ("13 Jul.", 11), ("14 Jul.", 8), ("15 Jul.", 15)
    ]
    
    let yearlyDataPoints: [(String, Double)] = [
        ("Jan.", 2), ("Feb.", -4), ("Mar.", 8), ("Apr.", 1), ("May.", 0), ("Jun.", 2), ("Jul.", 2),
        ("Aug.", -13), ("Sep.", -8), ("Oct.", 9), ("Nov.", 12), ("Dec.", -0.5)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    LinePointChartView(dataValues: weeklyDataPoints, title: "Weekly Data")
                    
                    LinePointChartView(dataValues: yearlyDataPoints, title: "Yearly Data")
                }
                .padding()
            }
            .navigationTitle("Line & Point Charts")
        }
    }
}

#Preview {
    ChartExampleView()
}
