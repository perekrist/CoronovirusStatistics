//
//  CountryModel.swift
//  CoronovirusStat
//
//  Created by Кристина Перегудова on 21.05.2020.
//  Copyright © 2020 Кристина Перегудова. All rights reserved.
//

import Foundation

struct CountryModel: Identifiable {
    var id: Int
    var name: String
    var flag: String
    var lat: Float
    var long: Float
    var cases: CasesModel
}
