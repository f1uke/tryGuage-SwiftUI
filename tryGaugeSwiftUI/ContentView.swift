//
//  ContentView.swift
//  tryGaugeSwiftUI
//
//  Created by Fluke on 6/10/2563 BE.
//

import SwiftUI
import ClockKit

struct ContentView: View {
    @State private var value = 25.0
    
    var body: some View {
        ScrollView {
            VStack {
                GaugeView(coveredRadius: 180, maxValue: 100, steperSplit: 20, value: $value)
                
                CustomGauge(value: self.value, scale: 5.0).frame(width: 300, height: 300, alignment: .center)
                Meter(progress: $value)
                Group {
                    Slider(value: $value, in: 0...100, step: 1)
                        .padding(.horizontal, 20)
                    HStack {
                        Spacer()
                        Button(action: {
                            self.value = 0
                        }) {
                            Text("Zero")
                        }.foregroundColor(.blue)
                        Spacer()
                        Button(action: {
                            self.value = 100
                        }) {
                            Text("Max")
                        }.foregroundColor(.blue)
                        Spacer()
                    }
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11")
        }
    }
}
