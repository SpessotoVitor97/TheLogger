//
//  UIView+Extensions.swift
//  Logger
//
//  Created by Vitor Spessoto on 5/12/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    //*************************************************
    // MARK: - Public methods
    //*************************************************
    func pinEdges(to parent: UIView, synchronous: Bool = false) {
        let pin: () -> Void = {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
            self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
        }
        
        if synchronous {
            pin()
        } else {
            DispatchQueue.main.async(execute: pin)
        }
    }
}
