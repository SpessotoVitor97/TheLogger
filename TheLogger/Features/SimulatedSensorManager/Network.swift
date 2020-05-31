//
//  Networking.swift
//  TheLogger
//
//  Created by Vitor Spessoto on 5/30/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import Foundation

class Network {
    
    func getSensors() -> [SensorType] {
        let sensors: [SensorType] = [.location, .temperature, .windSpeed]
        return sensors
    }
}
