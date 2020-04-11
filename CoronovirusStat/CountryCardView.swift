//
//  CountryCardView.swift
//  CoronovirusStat
//
//  Created by Кристина Перегудова on 31.03.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CountryCardView: View {
    
    var country: Country
    
    var body: some View {
        VStack {
            HStack {
                WebImage(url: URL(string: "\(self.country.flag)"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding(.top, 20)
                
                Text(self.country.name)
                    .font(.title)
                    .bold()
                    .padding(.top, 20)
            }
            
            HStack {
                VStack {
                    Text("Active Cases")
                        .font(.system(size: 30))
                    Text("\(self.country.cases.casesCount)")
                        .font(.system(size: 40))
                }
                
                VStack {
                    Text("Deaths")
                        .font(.system(size: 20))
                    
                    Text("\(self.country.cases.deaths)")
                    .font(.system(size: 20))
                        .foregroundColor(.red)
                    .shadow(radius: 20)
                    
                    Divider()
                    
                    Text("Recovered")
                        .font(.system(size: 20))
                    
                    Text("\(self.country.cases.recovered)")
                    .font(.system(size: 20))
                        .foregroundColor(.green)
                    .shadow(radius: 20)
                    
                    Divider()

                    Text("Critical")
                        .font(.system(size: 20))
                    
                    Text("\(self.country.cases.critical)")
                        .font(.system(size: 20))
                        .foregroundColor(.yellow)
                        .shadow(radius: 20)
                }.background(Color.white.opacity(0.5))
                .cornerRadius(20)
                .padding(.bottom, 20)
            }
        }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.width / 2 + 50)
        .background(Color.init(generateRandomColor()).opacity(0.5))
            .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 10)
        .padding(.vertical)
    }
    
    func generateRandomColor() -> UIColor {
          let hue : CGFloat = CGFloat(arc4random() % 256) / 256
          let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
          let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
                
          return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}

struct CountryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CountryCardView(country: .init(id: 0, name: "USA", flag: "", lat: 0, long: 0, cases: Cases(id: UUID(), casesCount: 100000, todayCases: 100, deaths: 90, todayDeaths: 15, recovered: 111, critical: 12, updated: "Mar - 02 - 2020 16:30 AM")))
            .previewLayout(.sizeThatFits)
    }
}
