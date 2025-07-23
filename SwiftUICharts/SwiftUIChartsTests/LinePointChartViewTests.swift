//
//  LinePointChartViewTests.swift
//  SwiftUICharts
//
//  Created by Swati Sharma
//

import XCTest
import SwiftUI
import Charts
@testable import SwiftUICharts

final class LinePointChartViewTests: XCTestCase {

    let sampleData: [(String, Double)] = [
        ("2025-01-01", 20),
        ("2025-02-01", 40),
        ("2025-03-01", 60)
    ]
    
    func testLinePointChartViewWithSampleData() {
        let sut = LinePointChartView(dataValues: sampleData, title: "Test Chart")
        let hostingController = UIHostingController(rootView: sut)
        XCTAssertNotNil(hostingController.view)
    }
}
