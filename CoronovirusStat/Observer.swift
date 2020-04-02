//
//  Observer.swift
//  CoronovirusStat
//
//  Created by Кристина Перегудова on 30.03.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Observer: ObservableObject {
    
    var baseUrl = "https://corona.lmao.ninja/"
    
    @Published var countries = [Country]()
    @Published var summaryCase = Cases(id: UUID(), casesCount: 0, todayCases: 0, deaths: 0, todayDeaths: 0, recovered: 0, critical: 0, updated: "")
    
    func upd() {
        getStat()
        getContriesStat()
    }
    
    func getStat() {
        AF.request(baseUrl + "all").responseJSON { (data) in
            let json = try! JSON(data: data.data!)
            
            self.summaryCase = Cases(id: UUID(),
                            casesCount: json["cases"].intValue,
                             todayCases: nil,
                             deaths: json["deaths"].intValue,
                             todayDeaths: nil,
                             recovered: json["recovered"].intValue,
                             critical: json["critical"].intValue,
                             updated: self.getDate(time: json["updated"].intValue)
            )
        }
    }
    
    func getContriesStat() {
        self.countries.removeAll()
        
        AF.request(baseUrl + "countries").responseJSON { (data) in
            let json = try! JSON(data.data)
            
            for i in json {
                let countryInfo = i.1["countryInfo"]
                let country = Country(id: countryInfo["_id"].intValue,
                                      name: i.1["country"].stringValue,
                                      flag: countryInfo["flag"].stringValue,
                                      lat: countryInfo["lat"].floatValue,
                                      long: countryInfo["lonf"].floatValue,
                        cases: Cases(id: UUID(),
                                    casesCount: i.1["cases"].intValue,
                                    todayCases: i.1["todayCases"].intValue,
                                    deaths: i.1["deaths"].intValue,
                                    todayDeaths: i.1["todayDeaths"].intValue,
                                    recovered: i.1["recovered"].intValue,
                                    critical: i.1["critical"].intValue,
                                    updated: self.getDate(time: i.1["updated"].intValue)
                        )
                )
                self.countries.append(country)
            }
        }
    }
    
    func getDate(time: Int) -> String {
        let date = Double(time / 1000)
        let format = DateFormatter()
        format.dateFormat = "dd MMM YYYY hh:mm a"
        
        return format.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: date)!))
    }
    
    
}
