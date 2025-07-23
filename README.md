📊 **Swift Charts in SwiftUI**

Charts is Apple’s native framework introduced in iOS 16, macOS 13, and other recent platforms, allowing developers to easily build beautiful and interactive charts using SwiftUI.

**🚀 Features of Swift Charts**

- 📈 Built-in chart types: LineMark, BarMark, PointMark, etc.

- 🎯 Smooth animations and interpolation

- 🔍 Tooltips and gestures support via ChartOverlay and RuleMark

- 🧲 Customizable axes, grid lines, annotations

- 🔄 SwiftUI-native syntax: works seamlessly with @State, ForEach, and layout views

**📚 Resources**

- Apple's Swift Charts Documentation:-
  https://developer.apple.com/documentation/charts
  
- WWDC 2022:-
  Swift Charts: https://developer.apple.com/videos/play/wwdc2022/10072/

## 🧩 Sample Usage

```swiftui
LinePointChartView(
    dataValues: [
        ("2025-01", 25),
        ("2025-02", 35),
        ("2025-03", 45),
        ("2025-04", 55),
        ("2025-05", 30)
    ],
    title: "Monthly Growth"
)

<img width="1206" height="2622" alt="a" src="https://github.com/user-attachments/assets/598584a6-e9de-4a3b-9219-93d79cceddd1" />
