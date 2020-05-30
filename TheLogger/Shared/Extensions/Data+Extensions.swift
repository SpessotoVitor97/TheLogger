//
//  Data+Extensions.swift
//  Logger
//
//  Created by Vitor Spessoto on 5/16/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import Foundation

extension Data {
    
    public static func fromJSON(fileName: String,
                                file: StaticString = #file,
                                line: UInt = #line) throws -> Data {
        
    let bundle = Bundle(for: GenericBundleClass.self)
    guard let url = bundle.url(forResource: fileName, withExtension: ".json") else { return Data() }
    return try Data(contentsOf: url)
    }
}

private class GenericBundleClass { }
