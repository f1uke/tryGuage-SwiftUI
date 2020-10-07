//
//  MeterView.swift
//  tryGaugeSwiftUI
//
//  Created by Fluke on 6/10/2563 BE.
//
///https://kavsoft.dev/Swift/SpeedoMeter/

import SwiftUI

struct Meter : View {
    
    let colors = [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)),Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))]
    @Binding var progress : Double
    
    private let gradient = AngularGradient(
        gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)),Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))]),
        center: .center,
        startAngle: .degrees(270),
        endAngle: .degrees(0))
    
    var body: some View{
        
        ZStack{
            
            ZStack{
                
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(style: StrokeStyle(lineWidth: 55.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.black.opacity(0.1))
                    .frame(width: 280, height: 280)
                
                
                Circle()
                    .trim(from: 0, to: self.setProgress())
                    .stroke(gradient, style: StrokeStyle(lineWidth: 46, lineCap: .round))
                    .frame(width: 280, height: 280)
                
            }
            .rotationEffect(.init(degrees: 180))
            .animation(.linear)
            
//            ZStack(alignment: .bottom) {
//
//                self.colors[0]
//                    .frame(width: 2, height: 95)
//
//                Circle()
//                    .fill(self.colors[0])
//                    .frame(width: 15, height: 15)
//            }
//            .offset(y: -35)
//            .rotationEffect(.init(degrees: -90))
//            .rotationEffect(.init(degrees: self.setArrow()))
//            .animation(.linear)
            
            
        }
        .padding(.bottom, -140)
    }
    
    func setProgress()->CGFloat{
        
        let temp = self.progress / 2
        return CGFloat(temp * 0.01)
    }
    
    func setArrow()->Double{
        
        let temp = self.progress / 100
        return Double(temp * 180)
    }
}

struct MeterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Meter(progress: .constant(40.0))
        }
    }
}
