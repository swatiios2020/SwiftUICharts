//
//  ChartsView.swift
//  SwiftUICharts
//
//  Created by Swati Sharma
//
import SwiftUI
import Charts

struct LinePointChartView: View {
    
    // MARK: - Variables
    let dataValues: [(String, Double)]
    let title: String
    
    private var min: Double { (dataValues.map(\.1).min() ?? 0) - 5 }
    private var max: Double { (dataValues.map(\.1).max() ?? 0) + 5 }
    
    @State private var currentValue: (String, Double)? = nil
    @State private var showToolTip = false
    @State private var annotationPosition: AnnotationPosition = .leading
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.headline)
                Divider()
                    .foregroundColor(Color(red: 0.82, green: 0.82, blue: 0.82))
            }.padding()
            
            Chart {
                ForEach(dataValues, id: \.0) { dataPoint in
                    LineMark(
                        x: .value("Date", dataPoint.0),
                        y: .value("Data", dataPoint.1)
                    )
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(Color(red: 0, green: 0.09, blue: 0.42))
                    .symbol(Circle().strokeBorder(lineWidth: 2))
                }
                
                if let currentValue = currentValue, showToolTip {
                    RuleMark(x: .value("Dragged Date", currentValue.0))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: []))
                        .foregroundStyle(Color(red: 0, green: 0.09, blue: 0.42))
                        .annotation(position: annotationPosition, alignment: .leading, spacing: 8) {
                            VStack {
                                Text("Date: \(currentValue.0)")
                                Text("Data: \(Int(currentValue.1))%")
                            }
                            .font(.caption)
                            .padding(8)
                            .background(Color.gray.opacity(0.7))
                            .cornerRadius(8)
                            .transition(.scale)
                            .animation(.default, value: annotationPosition)
                        }
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic) {
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                    AxisValueLabel(centered: false)
                }
            }
            .chartYAxis {
                let yValues: [Double] = (Array(stride(from: min, through: max, by: 5)) + [0.0])
                AxisMarks(position: .leading, values: yValues) { value in
                    if value.as(Double.self) == 0.0 {
                        AxisGridLine(stroke: .init(dash: [2]))
                            .foregroundStyle(Color(red: 0.22, green: 0.18, blue: 0.17))
                        AxisValueLabel()
                    } else {
                        AxisGridLine()
                        AxisValueLabel()
                    }
                }
            }
            .chartOverlay { proxy in
                GeometryReader { geometry in
                    Rectangle()
                        .fill(.clear)
                        .contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    guard let frame = proxy.plotFrame else { return }
                                    let relativeXPosition = value.location.x - geometry[frame].origin.x
                                    if let xValue: String = proxy.value(atX: relativeXPosition),
                                       dataValues.contains(where: { $0.0 == xValue }) {
                                        let yData = dataValues.first(where: { $0.0 == xValue })?.1 ?? 0
                                        withAnimation {
                                            currentValue = (xValue, yData)
                                            showToolTip = true
                                            annotationPosition = relativeXPosition / geometry[frame].size.width > 0.75 ? .leading : .trailing
                                        }
                                    } else {
                                        withAnimation {
                                            showToolTip = false
                                        }
                                    }
                                }
                        )
                        .simultaneousGesture(
                            SpatialTapGesture().onEnded { value in
                                guard let frame = proxy.plotFrame else { return }
                                let relativeXPosition = value.location.x - geometry[frame].origin.x
                                if let xValue: String = proxy.value(atX: relativeXPosition),
                                   dataValues.contains(where: { $0.0 == xValue }) {
                                    let yData = dataValues.first(where: { $0.0 == xValue })?.1 ?? 0
                                    let newValue: (String, Double)? = (xValue, yData)
                                    withAnimation {
                                        if currentValue?.0 == xValue, showToolTip {
                                            showToolTip = false
                                        } else {
                                            currentValue = newValue
                                            showToolTip = true
                                            annotationPosition = relativeXPosition / geometry[frame].size.width > 0.75 ? .leading : .trailing
                                        }
                                    }
                                } else {
                                    withAnimation {
                                        showToolTip = false
                                    }
                                }
                            }
                        )
                }
            }
            .frame(width: 328, height: 204)
            .padding(.horizontal, 16)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(red: 0.82, green: 0.82, blue: 0.82), lineWidth: 1)
                .padding(.vertical, -4)
                .padding(.horizontal, 16)
        )
    }
}
