//
//  ResultModel.swift
//  sunriseset
//
//  Created by Mohammed Al-Quraini on 8/12/21.
//

import UIKit

struct DataModel : Codable{
    let results : Result
}

struct Result : Codable {
    let sunrise : String
    let sunset : String
    let solar_noon : String
    let day_length : String
    let civil_twilight_begin : String
    let civil_twilight_end : String
    let nautical_twilight_begin : String
    let nautical_twilight_end : String
    let astronomical_twilight_begin : String
    let astronomical_twilight_end : String
    
}


