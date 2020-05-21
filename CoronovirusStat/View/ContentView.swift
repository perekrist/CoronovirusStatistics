//
//  ContentView.swift
//  CoronovirusStat
//
//  Created by Кристина Перегудова on 30.03.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var x : CGFloat = 0
    @State var count : CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    
    @ObservedObject var coronaVirusViewModel = CoronaVirusViewModel()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            if self.coronaVirusViewModel.summaryCase != nil {
                VStack {
                    HStack {
                        Text(self.coronaVirusViewModel.summaryCase!.updated)
                            .foregroundColor(.gray)
                            .font(.system(size: 25))
                            .padding()
                        
                        Spacer()
                        
                        Button(action: {
                            self.coronaVirusViewModel.update()
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                    .padding(.bottom, 20)
                    
                    VStack {
                        Text("COVID - 19 Cases")
                            .font(.title)
                            .padding()
                        
                        Text("\(self.coronaVirusViewModel.summaryCase!.casesCount)")
                            .foregroundColor(.gray)
                            .font(.largeTitle)
                            .bold()
                        
                        Divider()
                        
                        Text("Deaths")
                            .font(.body)
                        
                        Text("\(self.coronaVirusViewModel.summaryCase!.deaths)")
                            .foregroundColor(.red)
                            .font(.title)
                            .bold()
                        
                        Divider()
                        
                        Text("Recovered")
                            .font(.body)
                        
                        Text("\(self.coronaVirusViewModel.summaryCase!.recovered)")
                            .foregroundColor(.green)
                            .font(.title)
                            .bold()
                            .padding(.bottom)
                        
                    }
                    .background(Color.white)
                    .frame(width: UIScreen.main.bounds.width)
                    
                    HStack(spacing: 15) {
                        ForEach(self.coronaVirusViewModel.countries) { country in
                            CountryCardView(country: country)
                                .offset(x: self.x)
                                .highPriorityGesture(DragGesture()
                                    .onChanged({ (value) in
                                        if value.translation.width > 0 {
                                            self.x = value.location.x
                                        } else {
                                            self.x = value.location.x - self.screen
                                        }
                                    })
                                    .onEnded({ (value) in
                                        if value.translation.width > 0 {
                                            if value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != self.coronaVirusViewModel.countries.count {
                                                self.count -= 1
                                                self.x = -((self.screen + 15) * self.count)
                                            } else {
                                                self.x = -((self.screen + 15) * self.count)
                                            }
                                        } else {
                                            if -value.translation.width > ((self.screen - 80) / 2) && Int(self.count) !=  (self.coronaVirusViewModel.countries.count / 2) {
                                                self.count += 1
                                                self.x = -((self.screen + 15) * self.count)
                                            } else {
                                                self.x = -((self.screen + 15) * self.count)
                                            }
                                        }
                                    })
                            )
                        }
                    }
                    .animation(.spring())
                }
                
                Spacer()
                
            }
            
            if self.coronaVirusViewModel.isLoading {
                LoaderView()
            }
            
        }.onAppear {
            self.coronaVirusViewModel.update()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
