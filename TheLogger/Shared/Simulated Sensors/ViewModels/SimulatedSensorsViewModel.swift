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
    func getSensorInfo() -> [String: Any] {
        let sensorID = model.sensorID
        let tracks = model.tracks
//        let signalForce = tracks.signalForce
//        let trackedValue = tracks.trackedValue
//        let location: LocationModel = tracks.location
//
//        let outputTracker = OutputTracksModel(sensorID: sensorID, signalForce: signalForce, trackedValue: trackedValue, location: location)
        
//        let outputTracker = SimulatedSensorModel(sensorID: sensorID, tracks: tracks)
        
        let outputTracker: [String: Any] = [
            "SensorID": sensorID,
            "tracks": tracks
        ]
        
        return outputTracker
    }
}
