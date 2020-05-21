//
//  Cases.swift
//  CoronovirusStat
//
//  Created by Кристина Перегудова on 21.05.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation

struct CasesModel: Identifiable {
    var id: UUID
    var casesCount: Int
    var todayCases: Int?
    var deaths: Int
    var todayDeaths: Int?
    var recovered: Int
    var critical: Int
    var updated: String
}
