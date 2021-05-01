//
//  API.swift
//  TheKnow
//
//  Created by Tom Margosian on 3/16/21.
//

import Foundation

struct Routes {
    static let BASE = "https://txm5483-theknow-api.herokuapp.com"
    static let LOGIN = "\(BASE)/login"
    static let SIGNUP = "\(BASE)/signup"
    static let LOGOUT = "\(BASE)/logout"
    static let GET_ALL_COLLECTIONS = "\(BASE)/collections"
    static let GET_LIST = "\(BASE)/collec"
}

struct Headers {
    static let AUTH = "x-access-token"
}

struct BodyParams {
    static let USER = "user"
}

class API {

}
