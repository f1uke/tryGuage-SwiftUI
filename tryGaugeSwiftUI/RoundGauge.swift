//
//  RoundGauge.swift
//  tryGaugeSwiftUI
//
//  Created by Fluke on 6/10/2563 BE.
//
/// https://oliver-epper.de/posts/how-to-create-a-self-sizing-gauge-componen-in-swiftui/

import SwiftUI

public struct CustomGauge<T>: View where T: View {
    let centerView: T
    let value: Double
    
    let thickness: CGFloat = 5
    let scale: CGFloat
    
    let gradient = AngularGradient(
        gradient: Gradient(
            colors: [
                .red,
                .green
            ]
        ),
        center: .center
    )
    
    @State private var diameter: CGFloat = 0
    
    public init(value: Double, scale: CGFloat, @GaugeBuilder builder: () -> T) {
        self.value = value
        self.scale = scale
        self.centerView = builder()
    }
    
    public var body: some View {
        ZStack {
            centerView.background(
                GeometryReader { proxy in
                    Color.clear.preference(key: GaugeWidthPreferenceKey.self, value: proxy.size.width)
                }
            )
            Group {
                Circle()
                    .stroke(Color.primary.opacity(0.2), style: .init(lineWidth: thickness/scale, dash: [5]))
                Circle()
                    .trim(from: 0, to: CGFloat(value/100))
                    .stroke(gradient, style: .init(lineWidth: thickness))
            }
            .padding(thickness/2)
            .rotationEffect(.degrees(180))
            .animation(.linear)
            .frame(width: diameter, height: diameter)
        }.onPreferenceChange(GaugeWidthPreferenceKey.self) { width in
            self.diameter = width * self.scale
        }
    }
}

extension CustomGauge where T == ZStack<TupleView<(Text, Text)>> {
    public init(value: Double, scale: CGFloat) {
        self.value = value
        self.scale = scale
        self.centerView = ZStack {
            Text("100 %").foregroundColor(.clear)
            Text("\(value, specifier: "%.0f") %")
        }
    }
}

@_functionBuilder
struct GaugeBuilder {
    static func buildBlock<T: View>(_ centerView: T) -> T {
        centerView
    }
}

struct GaugeWidthPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct RoundGauge_Previews: PreviewProvider {
    static var previews: some View {
        CustomGauge(value: 10.0, scale: 2.0)
    }
}
