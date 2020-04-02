//
//  Structs.swift
//  CoronovirusStat
//
//  Created by Кристина Перегудова on 30.03.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation

struct Country: Identifiable {
    var id: Int
    var name: String
    var flag: String
    var lat: Float
    var long: Float
    var cases: Cases
}

struct Cases: Identifiable {
    var id: UUID
    var casesCount: Int
    var todayCases: Int?
    var deaths: Int
    var todayDeaths: Int?
    var recovered: Int
    var critical: Int
    var updated: String
}
