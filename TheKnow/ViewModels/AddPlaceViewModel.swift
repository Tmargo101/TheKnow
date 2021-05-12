//
//  AddPlaceViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 5/11/21.
//

import Foundation
import Alamofire

class AddPlaceViewModel: ObservableObject {
    
    @Published var place = Place()
    
    @Published var responseMessage = ""
    
    @Published var newPlaceName = ""
    @Published var newPlaceRecommendedBy = ""
    @Published var been = false
    @Published var newPlaceCollectionId = ""
    
    func addPlace(token: String, _name: String, addedBy: String, collectionId: String, been: Bool, recommendedBy: String, completion: @escaping (Bool) -> Void) {
        var beenString = "false"
        if (been) { beenString = "true" }
        
        let headers: HTTPHeaders = [Headers.AUTH: token]
        let parameters = [
            "name": _name,
            "addedBy": addedBy,
            "collectionId": collectionId,
            "been": beenString,
            "recommendedBy": recommendedBy,
        ]
        AF.request(Routes.GET_PLACES,
                   method: .post,
                   parameters: parameters,
                   headers: headers
        )
        .responseJSON() { response in
            print(response)
        }
    //        .validate()
        .responseDecodable(of: APIResponse.self) { (response) in
            guard let response = response.value else {
                print(response)
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
