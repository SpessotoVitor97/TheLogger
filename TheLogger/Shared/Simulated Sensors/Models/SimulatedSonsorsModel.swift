//
//  SimulatedSonsorsModel.swift
//  TheLogger
//
//  Created by Vitor Spessoto on 5/30/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import Foundation

struct SimulatedSensorModel: Codable {
    var sensorID: String
    var tracks: [TracksModel]
    
}
