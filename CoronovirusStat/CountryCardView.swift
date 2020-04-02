//
//  CountryCardView.swift
//  CoronovirusStat
//
//  Created by Кристина Перегудова on 31.03.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import SwiftUI

struct CountryCardView: View {
    
    var country: Country
    
    var body: some View {
        VStack {
            HStack {
                Text(self.country.name)
                    .font(.title)
                    .bold()
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
                    
                    Divider()
                    
                    Text("Recovered")
                        .font(.system(size: 20))
                    
                    Text("\(self.country.cases.recovered)")
                    .font(.system(size: 20))
                        .foregroundColor(.green)
                    
                    Divider()

                    Text("Critical")
                        .font(.system(size: 20))
                    
                    Text("\(self.country.cases.critical)")
                    .font(.system(size: 20))
                        .foregroundColor(.yellow)
                }.padding() 
            }
        }
            .padding()
        .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.width / 2 + 50)
            .background(Color.white)
            .cornerRadius(20)
    }
}

struct CountryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CountryCardView(country: .init(id: 0, name: "USA", flag: "", lat: 0, long: 0, cases: Cases(id: UUID(), casesCount: 100000, todayCases: 100, deaths: 90, todayDeaths: 15, recovered: 111, critical: 12, updated: "Mar - 02 - 2020 16:30 AM")))
            .previewLayout(.sizeThatFits)
    }
}
