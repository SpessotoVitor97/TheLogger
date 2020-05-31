//
//  SimulatedSensorsViewModel.swift
//  TheLogger
//
//  Created by Vitor Spessoto on 5/30/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import Foundation

class SimulatedSensorsViewModel {
    
    //*************************************************
    // MARK: - Public properties
    //*************************************************
    var hasData = false
    
    //*************************************************
    // MARK: - Private properties
    //*************************************************
    private var model: SimulatedSensorModel
    
    //*************************************************
    // MARK: - Initializers
    //*************************************************
    init(with model: SimulatedSensorModel) {
        self.model = model
    }
    
    //*************************************************
    // MARK: - Public methods
    //*************************************************
    func getSensorType() -> SensorType {
        let sensorID = model.sensorID
        
        if sensorID == "QWERTYJUMPERLOC" {
            return .location
        } else if sensorID == "QWERTYFREEZINGHELL" {
            return .temperature
        } else {
            return .windSpeed
        }
    }
    
    func getSensorTracks() -> [TracksModel] {
        let tracks = model.tracks
        return tracks
    }
}
