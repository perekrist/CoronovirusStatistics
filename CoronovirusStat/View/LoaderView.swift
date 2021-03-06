//
//  LoaderView.swift
//  CoronovirusStat
//
//  Created by Кристина Перегудова on 21.05.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct LoaderView: View {
    
    @State var show = false
    
    var body : some View {
        ZStack {
            Color.black
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .frame(width: 35, height: 35)
                .rotationEffect(.init(degrees: self.show ? 360 : 0))
                .animation(Animation.default.repeatForever(autoreverses: false).speed(1))
                .padding(40)
                .background(Color.white)
                .cornerRadius(15)
                .onAppear {
                    self.show.toggle()
            }
            
        }
    }
    
}
