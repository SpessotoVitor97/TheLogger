//
//  ViewController.swift
//  TheLogger
//
//  Created by Vitor Spessoto on 5/28/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //*************************************************
    // MARK: - Private properties
    //*************************************************
    private var model: SimulatedSensorModel?
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
//        if let localData = self.readLocalFile(forName: "JumperSensor1") {
//            self.parse(jsonData: localData)
//        }
    }
    
    //*************************************************
    // MARK: - Private methods
    //*************************************************
    private func setupNavigationBar() {
        navigationItem.title = "The Logger"
    }
    
    private func setupUI() {
        view.backgroundColor = StyleGuide.ViewStyle.View.backgroundColor
        
        
        let label = UILabel()
        let frame = UIScreen.main.bounds
        
        label.frame = CGRect(x: frame.minX + 10, y: frame.minY + 100, width: frame.width - 20, height: 31)
        label.text = "Testing..."
        label.configure(style: .bigText)
        
        view.addSubview(label)
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
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: ".json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}

