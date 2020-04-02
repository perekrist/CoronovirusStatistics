//
//  ContentView.swift
//  CoronovirusStat
//
//  Created by Кристина Перегудова on 30.03.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var observer = Observer()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text(self.observer.summaryCase.updated)
                        .foregroundColor(.gray)
                        .font(.system(size: 25))
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        self.observer.upd()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }.padding(.bottom, 20)
                                
                VStack {
                    Text("COVID - 19 Cases")
                        .font(.title)
                        .padding()
                    
                    Text("Deaths")
                        .font(.body)
                    
                    Text("\(self.observer.summaryCase.deaths)")
                        .foregroundColor(.red)
                        .font(.title)
                        .bold()
                    
                    Divider()
                    
                    Text("Recovered")
                        .font(.body)
                    
                    Text("\(self.observer.summaryCase.recovered)")
                        .foregroundColor(.green)
                        .font(.title)
                        .bold()
                        .padding(.bottom)
                    
                }
                .background(Color.white)
                .frame(width: UIScreen.main.bounds.width)
                
                                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Text("")
                            .frame(height: UIScreen.main.bounds.width / 2 + 60)
                        ForEach(self.observer.countries) {country in
                            CountryCardView(country: country)
                        }
                    }
                }.padding(.vertical)
                
                Spacer()
                
            }.onAppear {
                self.observer.upd()
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
