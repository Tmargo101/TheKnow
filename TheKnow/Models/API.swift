//
//  API.swift
//  TheKnow
//
//  Created by Tom Margosian on 3/16/21.
//

import Foundation
import Alamofire

struct Routes {
    static let BASE = "http://localhost:3000"
    static let GET_LISTS = "\(BASE)/lists"
    static let GET_LIST = "\(BASE)/list/"
}

class API {
    
    static let shared = API()
    
    func getLists(completion: @escaping ([PlaceList]?) -> Void) {
        print(Routes.GET_LISTS)
        AF.request(Routes.GET_LISTS).responseJSON { (response) in
            
            guard let data = response.data else {
                completion(nil)
                return
            }
            
            do {
                let placeLists = try JSONDecoder().decode([PlaceList].self, from: data)
                completion(placeLists)
            } catch {
                completion(nil)
                print(error)
            }
        }
    }

}
