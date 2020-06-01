//
//  Enums.swift
//  TheLogger
//
//  Created by Vitor Spessoto on 5/30/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import Foundation

enum SensorType {
    case location
    case temperature
    case windSpeed
    
    var type: String {
        switch self {
        case .location:
            return "Location"
        case .temperature:
            return "Temperature"
        case .windSpeed:
            return "WindSpeed"
        }
    }
}
