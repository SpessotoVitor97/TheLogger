//
//  SimulatedSensorManager.swift
//  TheLogger
//
//  Created by Vitor Spessoto on 5/30/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import Foundation

protocol SimulatedSensorManagerDelegate: NSObject {
    func appendToOutputJSON(newTrack: SimulatedSensorModel)
}

class SimulatedSensorManager {
    typealias conectedSensorsHandler = (([SensorType]) -> Void)
    
    //*************************************************
    // MARK: - Public properties
    //*************************************************
    var model: SimulatedSensorModel?
    var json = [String: Any]()
    
    //*************************************************
    // MARK: - Private properties
    //*************************************************
    private let network = Network()
    private weak var delegate: SimulatedSensorManagerDelegate?
    
    //*************************************************
    // MARK: - Public methods
    //*************************************************
    func identifyConectedSensors(completion: @escaping conectedSensorsHandler) {
        let sensors = network.getSensors()
        let mockedJSONs = ["JumperSensor1", "FreezingHellSensor1", "GodSpeedSensor1"]
        mockedJSONs.forEach { (fileName) in
            if let localData = self.readLocalFile(forName: fileName) {
                self.parse(jsonData: localData)
                guard let sensorID = self.model?.sensorID else { return }
                json[sensorID] = self.JSONToDictionary(data: localData)
            }
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
            print("error reading local file: \(error)")
        }
        return nil
    }
    
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(SimulatedSensorModel.self,
                                                       from: jsonData)
            model = decodedData
        } catch {
            print("error parsing JSON: \(error)")
        }
    }
    
    private func JSONToDictionary(data: Data) -> Any? {
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: [])
            guard let json = object as? [String: Any] else { return nil }
            return json
        } catch {
            print("error transforming JSON to dictionary: \(error)")
        }
        return nil
    }
}
