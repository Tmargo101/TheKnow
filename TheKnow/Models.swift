//
//  Models.swift
//  TheKnow
//
//  Created by Tom Margosian on 3/16/21.
//

import Foundation

struct PlaceList: Codable {
    let name: String
    let id: Int
}

struct Place: Codable {
    var name: String
    var address: String
    var notes: String
    var reccomendedBy: String
    var id: String
    var been: Bool
}
