//
//  OutputTimerself.swift
//  TheLogger
//
//  Created by Vitor Spessoto on 5/30/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import UIKit

protocol OutputTimerViewDelegate: NSObject {
    func didFinishCountDown()
}

class OutputTimerView {
    
    //*************************************************
    // MARK: - UI Shared components
    //*************************************************
    private var timeLabel = UILabel()
    
    //*************************************************
    // MARK: - Public properties
    //*************************************************
    weak var delegate: OutputTimerViewDelegate?
    
    //*************************************************
    // MARK: - Private properties
    //*************************************************
    private let timeLeftShapeLayer = CAShapeLayer()
    private let bgShapeLayer = CAShapeLayer()
    private var endTime: Date?
    private var timer = Timer()
    private let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
    private var timeLeft: TimeInterval = 0
    
    private var view: UIView
    
    //*************************************************
    // MARK: - Initializers
    //*************************************************
    
    init(with view: UIView) {
        self.view = view
    }
    
    //*************************************************
    // MARK: - Public methods
    //*************************************************
    func setup() {
        drawBgShape()
        drawTimeLeftShape()
        addTimeTextField()
        strokeIt.fromValue = 0
        strokeIt.toValue = 1
    }
    
    func start(with timeLeft: Double) {
        self.timeLeft = timeLeft
        strokeIt.duration = timeLeft
        timeLabel.isUserInteractionEnabled = false
        timeLeftShapeLayer.add(strokeIt, forKey: nil)
        endTime = Date().addingTimeInterval(timeLeft)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    //*************************************************
    // MARK: - Private methods
    //*************************************************
    private func drawBgShape() {
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: self.view.frame.midX , y: self.view.frame.midY), radius:
            100, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        bgShapeLayer.strokeColor = UIColor.white.cgColor
        bgShapeLayer.fillColor = UIColor.clear.cgColor
        bgShapeLayer.lineWidth = 15
        self.view.layer.addSublayer(bgShapeLayer)
    }
    
    private func drawTimeLeftShape() {
        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: self.view.frame.midX , y: self.view.frame.midY), radius:
            100, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        timeLeftShapeLayer.strokeColor = UIColor.orange.cgColor
        timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
        timeLeftShapeLayer.lineWidth = 15
        self.view.layer.addSublayer(timeLeftShapeLayer)
    }
    
    private func addTimeTextField() {
        timeLabel = UILabel(frame: CGRect(x: self.view.frame.midX - 50 ,y: self.view.frame.midY - 25, width: 100, height: 50))
        timeLabel.textAlignment = .center
        timeLabel.text = timeLeft.time
        self.view.addSubview(timeLabel)
    }
    
    //*************************************************
    // MARK: - Actions
    //*************************************************
    @objc private func updateTime() {
    if timeLeft > 0 {
        timeLeft = endTime?.timeIntervalSinceNow ?? 0
        timeLabel.text = timeLeft.time
        } else {
        timeLabel.text = "00:00"
        timer.invalidate()
        delegate?.didFinishCountDown()
        }
    }
}

//*************************************************
// MARK: - TimerInterval
//*************************************************
extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}

//*************************************************
// MARK: - Int
//*************************************************
extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
