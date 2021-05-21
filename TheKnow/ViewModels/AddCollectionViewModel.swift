//
//  AddCollectionViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 5/7/21.
//

import Foundation
import Alamofire

class AddCollectionViewModel: ObservableObject {
    @Published var collection: Collection = Collection()
    @Published var newCollectionName: String = ""
    @Published var responseMessage = ""
    
    func addNewCollection(_name: String, usedId: String, token: String, completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [Headers.AUTH: token]
        let parameters = [
            "name": _name,
            "owner": usedId
        ]
        AF.request(Routes.GET_COLLECTIONS,
                   method: .post,
                   parameters: parameters,
                   headers: headers
        )
    //        .validate()
        .responseDecodable(of: APIResponse.self) { (response) in
            guard let response = response.value else {
                completion(false)
                return
            }
            if (response.status == "error") {
                self.responseMessage = response.message
                completion(false)
                return

            }
            
            completion(true)
        }
    }

}
