//
//  CollectionsViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 4/25/21.
//

import Foundation
import Alamofire
import SwiftUI

class CollectionsViewModel: ObservableObject {
    
    @Published var collections = [Collection]()
    @Published var collection = Collection()
    
    @Published var loadingCollections: Bool = true
    
//    func getAllCollections(token: String?, id: String?, completion: @escaping(Bool) -> Void) {
//        let _token = token ?? ""
//        let _id = id ?? ""
//        getAllCollectionsAPI(token: _token, id: _id) { Collections in
//           print(Collections)
//        }
//    }
    
    func getAllCollections(token: String?, id: String?, completion: @escaping (Bool) -> Void) {

        let headers: HTTPHeaders = [Headers.AUTH: token ?? ""]
        let parameters = [BodyParams.USER: id]
        AF.request(
            Routes.GET_COLLECTIONS,
            parameters: parameters,
            headers: headers
        )
        .validate()
//        .responseJSON { response in
//            print(response)
//        }
        .responseDecodable(of: APIResponse.self) { (response) in
            guard let response = response.value else {
                completion(false)
                return
            }
            self.collections = response.contents?.collections ?? []
            completion(true)
        }
    }
}
