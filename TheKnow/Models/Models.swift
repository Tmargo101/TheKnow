//
//  Models.swift
//  TheKnow
//
//  Created by Tom Margosian on 3/16/21.
//

import Foundation

//struct PlaceList: Codable {
//    let name: String
//    let id: Int
//}
//
//struct Place: Codable {
//    var name: String
//    var address: String
//    var notes: String
//    var reccomendedBy: String
//    var id: String
//    var been: Bool
//}

struct Response: Decodable {
    let status: String
    let message: String
    let contents: Contents
}

struct Contents: Decodable {
    let user: User?
    let collections: [Collection]?
}

struct User: Decodable {
    let id: String
    let token: String
}

struct Collection: Decodable, Identifiable {
    let id: String
    let createdDate: String
    let members: [String]
    let name: String
    let owner: String
    let places: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdDate = "createdDate"
        case members = "members"
        case name = "name"
        case owner = "owner"
        case places = "places"
    }
}
