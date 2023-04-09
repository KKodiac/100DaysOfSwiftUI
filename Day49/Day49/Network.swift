//
//  Network.swift
//  Day49
//
//  Created by Sean Hong on 2023/04/09.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
