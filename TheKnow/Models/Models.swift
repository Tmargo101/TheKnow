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

struct APIResponse: Decodable {
    let status: String
    let message: String
    let contents: Contents?
}

struct Contents: Decodable {
    let user: User?
    let collections: [Collection]?
    let collection: Collection?
    let places: [Place]?
//    let place: Place?
    let members: [Member]?
}

struct User: Decodable {
    let email: String
    let _id: String
    let token: String
    let tokenCount: String
    let name: UserName
    let createdDate: String
    
    init() {
        self.email = ""
        self._id = ""
        self.token = ""
        self.tokenCount = ""
        self.name = UserName()
        self.createdDate = ""
    }
}

struct UserName: Decodable {
    let first: String
    let last: String
    
    init() {
        self.first = ""
        self.last = ""
    }
}

struct Collection: Decodable, Identifiable {
    let id: String
    let createdDate: String
    let members: [String]
    let name: String
    let owner: String
    let places: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdDate = "createdDate"
        case members = "members"
        case name = "name"
        case owner = "owner"
        case places = "places"
    }
    
    init() {
        self.id = ""
        self.createdDate = ""
        self.members = [""]
        self.places = [""]
        self.owner = ""
        self.name = ""
    }
}

struct Place: Decodable, Identifiable {
    let id: String
    let name: String
    let addedBy: String
    let collectionId: String?
    let createdDate: String
    let recommendedBy: PlaceRecommendedBy?
    let placeData: PlaceData?
    let note: String?
    let comments: [PlaceComment]?
    let been: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case addedBy = "addedBy"
        case collectionId = "collectionId"
        case createdDate = "createdDate"
        case recommendedBy = "recommendedBy"
        case placeData = "placeData"
        case note = "note"
        case comments = "comments"
        case been = "been"
    }

    init() {
        self.id = ""
        self.name = ""
        self.addedBy = ""
        self.collectionId = ""
        self.createdDate = ""
        self.note = ""
        self.placeData = PlaceData()
        self.recommendedBy = PlaceRecommendedBy()
        self.comments = [PlaceComment()]
        self.been = false
    }
}

struct PlaceData: Decodable {
    let address: String?
    let link: String?
    let phoneNumber: String?
    let mapsLink: String?
    let yelpLink: String?
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case link = "link"
        case phoneNumber = "phoneNumber"
        case mapsLink = "mapsLink"
        case yelpLink = "yelpLink"
    }

    init() {
        self.mapsLink = ""
        self.yelpLink = ""
        self.phoneNumber = ""
        self.address = ""
        self.link = ""
    }
}

struct PlaceRecommendedBy: Decodable {
    let name: String?
    let id: String?
    
    init() {
        self.name = ""
        self.id = ""
    }
}

struct PlaceComment: Decodable, Hashable {
    let id: String?
    let name: String?
    let text: String?
    let userId: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case text = "text"
        case userId = "userId"
    }
    
    init() {
        self.id = ""
        self.name = ""
        self.text = ""
        self.userId = ""
    }
}

struct Member: Decodable {
    let id: String
    let email: String
    let name: UserName
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email = "email"
        case name = "name"
    }
    
    init() {
        self.id = ""
        self.name = UserName()
        self.email = ""
    }
}

