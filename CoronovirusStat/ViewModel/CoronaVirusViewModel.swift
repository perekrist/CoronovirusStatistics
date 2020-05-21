//
//  CoronaVirusViewModel.swift
//  CoronovirusStat
//
//  Created by Кристина Перегудова on 21.05.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CoronaVirusViewModel: ObservableObject {
    
    var baseUrl = "https://corona.lmao.ninja/v2/"
    
    @Published var countries = [CountryModel]()
    @Published var summaryCase: CasesModel?
    
    @Published var isLoading = false
    
    func update() {
        isLoading = true
        getStatistics()
        getContriesStatistics()
    }
    
    func getStatistics() {
        AF.request(baseUrl + "all").responseJSON { (data) in
            let json = try! JSON(data: data.data!)
            
            self.summaryCase = CasesModel(id: UUID(),
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
    
    func getContriesStatistics() {
        AF.request(baseUrl + "countries").responseJSON { (data) in
            let json = try! JSON(data.data)
            
            self.countries.removeAll()
            
            for i in json {
                let countryInfo = i.1["countryInfo"]
                let country = CountryModel(id: countryInfo["_id"].intValue,
                                      name: i.1["country"].stringValue,
                                      flag: countryInfo["flag"].stringValue,
                                      lat: countryInfo["lat"].floatValue,
                                      long: countryInfo["lonf"].floatValue,
                        cases: CasesModel(id: UUID(),
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
            
            self.isLoading = false
        }
    }
    
    func getDate(time: Int) -> String {
        let date = Double(time / 1000)
        let format = DateFormatter()
        format.dateFormat = "dd MMM YYYY hh:mm a"
        
        return format.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: date)!))
    }
    
}
