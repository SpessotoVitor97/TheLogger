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
    
    //*************************************************
    // MARK: - Private properties
    //*************************************************
    private var model: SimulatedSensorModel?
    private var sensors: [SensorType] = []
    
    private let manager = SimulatedSensorManager()
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        setupTextField()
        setupOutputTimer()
//        if let localData = self.readLocalFile(forName: "JumperSensor1") {
//            self.parse(jsonData: localData)
//        }
    }
    
    //*************************************************
    // MARK: - Actions
    //*************************************************
    @objc func getSensors() {
        sensors = manager.identifyConectedSensors()
        setupTitleLabel(with: "Conected sensors")
        setupSensorsLabels()
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
        button.setTitle("Get Sensors", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = StyleGuide.ViewStyle.Components.backgroundColor
        button.configure(style: .link, color: .white)
        button.addTarget(self, action: #selector(getSensors), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    private func setupTextField() {
        let frame = UIScreen.main.bounds

        let textField1 = UITextField()
        let width1 = (frame.width/3)
        textField1.frame = CGRect(x: frame.minX + 10, y: frame.minY + 250, width: width1 - 30, height: 31)
        textField1.backgroundColor = .white
        textField1.layer.borderWidth = 3.0
        textField1.layer.cornerRadius = 10

        let textField2 = UITextField()
        textField2.frame = CGRect(x: width1 + 3, y: frame.minY + 250, width: width1 - 30, height: 31)
        textField2.backgroundColor = .white
        textField2.layer.borderWidth = 3.0
        textField2.layer.cornerRadius = 10

        let textField3 = UITextField()
        textField3.frame = CGRect(x: frame.maxX - 125, y: frame.minY + 250, width: width1 - 30, height: 31)
        textField3.backgroundColor = .white
        textField3.layer.borderWidth = 3.0
        textField3.layer.cornerRadius = 10

        view.addSubview(textField1)
        view.addSubview(textField2)
        view.addSubview(textField3)
    }
    
    private func setupSensorsLabels() {
//        var labelsArray: [UILabel] = []
//
//        sensors.forEach { (sensor) in
//            let sensorLabel = UILabel()
//            sensorLabel.configure(style: .bigText, color: .blue)
//            sensorLabel.text = sensor.type
//            labelsArray.append(sensorLabel)
//        }
//
//        let stackView = UIStackView(arrangedSubviews: labelsArray)
//        stackView.axis = .horizontal
//        stackView.distribution = .fillProportionally
//        stackView.alignment = .center
//        stackView.spacing = 5
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(stackView)
//
//        //autolayout the stack view - pin 30 up 20 left 20 right 30 down
//        let viewsDictionary = ["stackView":stackView]
//        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[stackView]-20-|",  //horizontal constraint 20 points from left and right side
//            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
//            metrics: nil,
//            views: viewsDictionary)
//        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[stackView]-30-|", //vertical constraint 30 points from top and bottom
//            options: NSLayoutConstraint.FormatOptions(rawValue:0),
//            metrics: nil,
//            views: viewsDictionary)
//        view.addConstraints(stackView_H)
//        view.addConstraints(stackView_V)
        
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
    
    private func setupOutputTimer() {
        let timerView = UIView()
        let frame = UIScreen.main.bounds

        timerView.frame = CGRect(x: frame.minX + 30, y: frame.midY - 100, width: frame.width - 62, height: 290)
        timerView.layer.cornerRadius = 10
        timerView.backgroundColor = StyleGuide.ViewStyle.View.secondBackgroudColor
        view.addSubview(timerView)

        let timer = OutputTimerView(with: timerView)
        timer.setup(with: 10)
        timer.start()

        timer.delegate = self
        
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
            if let bundlePath = Bundle.main.path(forResource: name, ofType: ".json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}

extension ViewController: OutputTimerViewDelegate {
    func didFinishCountDown() {
        print("Finish timer. Send the data.")
    }
}

