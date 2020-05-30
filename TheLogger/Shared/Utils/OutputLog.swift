//
//  OutputLog.swift
//  Logger
//
//  Created by Vitor Spessoto on 5/16/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import UIKit

class OutputLog {
    class func log(with track: String, data: Data?) {
        let title = "\n -_-_-_-_-_- Output Logger -_-_-_-_-_- "
        let end =  "\n -_-_-_-_-_- END Log -_-_-_-_-_-_-_-_-\n"
        let jump = "\n"
        let tracks = "Tracks: \(track)"
        var outPut = ""
        
        print(title)
        defer {
            print(end)
        }
        
        if let body = data {
            let strData = NSString(data: body, encoding: String.Encoding.utf8.rawValue) as String? ?? ""
            outPut += track
            outPut += jump + strData
        }
        
        print(outPut)
    }
}
