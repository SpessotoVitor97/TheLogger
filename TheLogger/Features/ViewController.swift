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
    // MARK: - UI Shared Components
    //*************************************************
    private let titleLabel = UILabel()
    private let loadingView = UIActivityIndicatorView()
    private var timer: OutputTimerView? = nil
    private var alert = UIAlertController()
    
    //*************************************************
    // MARK: - Private properties
    //*************************************************
    private var viewModel: SimulatedSensorsViewModel?
    private var sensors: [SensorType] = []
    private var isReadyToSend = false
    private var hasConectedSensors = false
    private var outputJSON = [String: Any]()
    
    private let manager = SimulatedSensorManager()
    private let seconds: Double = 900
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupOutputTimerView()
    }
    
    //*************************************************
    // MARK: - Actions
    //*************************************************
    @objc private func getSensorsButtonTapped() {
        alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        loadingView.hidesWhenStopped = true
        loadingView.style = UIActivityIndicatorView.Style.medium
        loadingView.startAnimating()
        
        view.addSubview(loadingView)
        
        view.pinEdges(to: view)
        present(alert, animated: true, completion: nil)
        
        getSensors {
            self.loadingView.stopAnimating()
            self.alert.dismiss(animated: true) {
                self.setupTitleLabel(with: "Conected sensors")
                self.setupSensorsLabels()
                self.setupViewModel()
                self.hasConectedSensors = true
            }
        }
    }
    
    private func getSensors(completion: @escaping (() -> Void)) {
        manager.identifyConectedSensors { (sensors) in
            self.sensors = sensors
            completion()
        }
    }
    
    @objc private func dismissAlertControllerButtonTapped() {
        let action = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.alert.view.superview?.isUserInteractionEnabled = true
            self.alert.dismiss(animated: true) {
                self.timer?.start(with: self.seconds)
            }
        }
        alert.addAction(action)
    }
    
    //*************************************************
    // MARK: - Private methods
    //*************************************************
    private func setupUI() {
        navigationItem.title = "The Logger"
        view.backgroundColor = StyleGuide.ViewStyle.View.backgroundColor
        setupTitleLabel(with: "Waiting for sensors...", color: .red)
    }
    
    private func setupTitleLabel(with text: String, color: StyleGuide.TextColor = .primary) {
        let frame = UIScreen.main.bounds
        titleLabel.frame = CGRect(x: frame.minX + 10, y: frame.minY + 100, width: frame.width - 20, height: 31)
        titleLabel.textAlignment = .center
        titleLabel.text = text
        titleLabel.configure(style: .bigText, color: color)
        
        view.addSubview(titleLabel)
    }
    
    private func setupButton() {
        let button = UIButton()
        let frame = UIScreen.main.bounds

        button.frame = CGRect(x: frame.minX + 10, y: frame.maxY - 100, width: frame.width - 20, height: 41)
        button.setTitle("Conect Sensors", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = StyleGuide.ViewStyle.Components.backgroundColor
        button.configure(style: .link, color: .white)
        button.addTarget(self, action: #selector(getSensorsButtonTapped), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    private func setupSensorsLabels() {
        let frame = UIScreen.main.bounds
        let labelFrame = CGRect(x: frame.minX + 10, y: frame.minY + 150, width: frame.width - 20, height: 31)
        
        let sensorLabel1 = UILabel()
        sensorLabel1.frame = labelFrame
        sensorLabel1.textAlignment = .left
        sensorLabel1.text = sensors[0].type
        sensorLabel1.configure(style: .bigText, color: .blue)

        let sensorLabel2 = UILabel()
        sensorLabel2.frame = labelFrame
        sensorLabel2.textAlignment = .center
        sensorLabel2.text = sensors[1].type
        sensorLabel2.configure(style: .bigText, color: .blue)

        let sensorLabel3 = UILabel()
        sensorLabel3.frame = labelFrame
        sensorLabel3.textAlignment = .right
        sensorLabel3.text = sensors[2].type
        sensorLabel3.configure(style: .bigText, color: .blue)

        view.addSubview(sensorLabel1)
        view.addSubview(sensorLabel2)
        view.addSubview(sensorLabel3)
    }
    
    private func setupOutputTimerView() {
        timer = OutputTimerView(with: view)
        timer?.delegate = self
        timer?.setup()
        startTimer(withTimeleftOf: seconds)
    }
    
    private func startTimer(withTimeleftOf seconds: Double) {
        timer?.start(with: seconds)
    }
    
    private func setupViewModel() {
        guard let model = manager.model else { return }
        viewModel = SimulatedSensorsViewModel(with: model)
    }
    
    private func buildAndSendOutputJSON(mobileID: String, tracks: [String: Any], readyToSend: Bool = false) {
        outputJSON = [
            "MobileID": mobileID,
            "tracks": tracks
        ]
        
        if readyToSend {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: outputJSON, options: .prettyPrinted)
                OutputLog.log(with: "Sending...", data: jsonData)
            } catch {
                print("Error trying to send the data: \(error)")
            }
        }
    }
}

//*************************************************
// MARK: - OutputTimerViewDelegate
//*************************************************
extension ViewController: OutputTimerViewDelegate {
    func didFinishCountDown() {
        
        if hasConectedSensors {
            let tracks = manager.json
            guard let mobileID = UIDevice.current.identifierForVendor?.uuidString else { return }
            isReadyToSend = true
            buildAndSendOutputJSON(mobileID: mobileID, tracks: tracks, readyToSend: isReadyToSend)
            
        } else {
            alert = UIAlertController(title: "There are no sensors currently conected...", message: "Please, tap on 'Conect Sensors' button to fetch sensors.", preferredStyle: .actionSheet)
            let action = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                self.alert.view.superview?.isUserInteractionEnabled = true
                self.alert.dismiss(animated: true) {
                    self.timer?.start(with: self.seconds)
                }
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
}

