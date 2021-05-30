//
//  API.swift
//  TheKnow
//
//  Created by Tom Margosian on 3/16/21.
//

import Foundation
import Alamofire

struct Routes {
    static let BASE = "https://theknow-api.herokuapp.com"
    static let LOGIN = "\(BASE)/login"
    static let SIGNUP = "\(BASE)/signup"
    static let LOGOUT = "\(BASE)/logout"
    static let GET_COLLECTIONS = "\(BASE)/collections"
    static let GET_PLACES = "\(BASE)/places"
    static let GET_PLACE = "\(BASE)/places"
    static let GET_USER = "\(BASE)/user"
}

struct Headers {
    static let AUTH = "x-access-token"
}

struct BodyParams {
    static let USER = "user"
    static let COLLECTION = "collection"
    static let EMAIL = "email"
    static let FIRSTNAME = "firstname"
    static let LASTNAME = "lastname"
    static let PASSWORD = "pass"
    static let PASSWORD_CONFIRM = "pass2"
    static let PLACE = "place"
}

//
//func getAllCollectionsAPI(token: String, id: String, completion: @escaping (([Collection])) -> Void) {
//    
//    var collections: [Collection] = []
//
//    let headers: HTTPHeaders = [Headers.AUTH: token]
//    let parameters = [BodyParams.USER: id]
//    AF.request(
//        Routes.GET_COLLECTIONS,
//        parameters: parameters,
//        headers: headers
//    )
//    .validate()
//    .responseDecodable(of: APIResponse.self) { (response) in
//        guard let response = response.value else {
//            print(response)
//            completion(collections)
//            return
//        }
//        
//        collections = response.contents?.collections ?? []
//        completion(collections)
//    }
//}
//
