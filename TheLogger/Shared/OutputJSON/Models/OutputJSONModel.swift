//
//  OutputJSONModel.swift
//  TheLogger
//
//  Created by Vitor Spessoto on 5/31/20.
//  Copyright © 2020 Vitor Spessoto. All rights reserved.
//

import Foundation

struct OutputJSONModel: Codable {
    var mobileID: String
    var tracks: [OutputTracksModel]
}
