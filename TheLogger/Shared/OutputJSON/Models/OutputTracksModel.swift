//
//  OutputTracksModel.swift
//  TheLogger
//
//  Created by Vitor Spessoto on 5/31/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import Foundation

struct OutputTracksModel: Codable {
//    var sensorID: String
//    var signalForce: Float
//    var trackedValue: String
//    var location: LocationModel
    
    var sensorID: String
    var tracks: [TracksModel]
}
