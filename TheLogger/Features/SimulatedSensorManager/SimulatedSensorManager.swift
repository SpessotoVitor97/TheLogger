//
//  SimulatedSensorManager.swift
//  TheLogger
//
//  Created by Vitor Spessoto on 5/30/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import Foundation

class SimulatedSensorManager {
    private let network = Network()
    
    func identifyConectedSensors() -> [SensorType] {
        let sensors = network.getSensors()
        return sensors
    }
}
