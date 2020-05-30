//
//  UIColor+Extensions.swift
//  Logger
//
//  Created by Vitor Spessoto on 5/12/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexadecimal: Int) {
        let red = CGFloat((hexadecimal >> 16) & 0xff)
        let green = CGFloat((hexadecimal >> 8) & 0xff)
        let blue = CGFloat(hexadecimal & 0xff)
        
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format: "#%06x", rgb)
    }
}
