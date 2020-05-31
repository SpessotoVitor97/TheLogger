//
//  SimulatedSensorManager.swift
//  TheLogger
//
//  Created by Vitor Spessoto on 5/30/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import Foundation

class SimulatedSensorManager {
    //*************************************************
    // MARK: - Public properties
    //*************************************************
    var model: SimulatedSensorModel?
    
    //*************************************************
    // MARK: - Private properties
    //*************************************************
    private let network = Network()
    
    //*************************************************
    // MARK: - Public methods
    //*************************************************
    func identifyConectedSensors(completion: (([SensorType]) -> Void)) {
        let sensors = network.getSensors()
        if let localData = self.readLocalFile(forName: "JumperSensor1") {
            self.parse(jsonData: localData)
        }
        completion(sensors)
    }
}

//*************************************************
// MARK: - JSON Parsing
//*************************************************
extension SimulatedSensorManager {
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: ".json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(SimulatedSensorModel.self,
                                                       from: jsonData)
            model = decodedData
        } catch {
            print(error)
        }
    }
}
