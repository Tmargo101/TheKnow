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
    @Published var newPlaceBeen = false
    @Published var newPlaceCollectionId = ""
    @Published var newPlaceNote = ""
    @Published var newPlaceAddress = ""
    @Published var newPlacePhoneNumber = ""
    @Published var newPlaceLink = ""
    
    
    func addPlace(token: String, addedBy: String, collectionId: String, fullName: String?, completion: @escaping (Bool) -> Void) {
        
        // Convert "been" to string (necessary?)
        var beenString = "false"
        if (newPlaceBeen) { beenString = "true" }
        
        let headers: HTTPHeaders = [Headers.AUTH: token]
        let parameters = [
            "name": newPlaceName,
            "addedBy": addedBy,
            "collectionId": collectionId,
            "been": beenString,
            "recommendedBy": newPlaceRecommendedBy,
            "commentText": newPlaceNote,
            "commentName": fullName,
            "address": newPlaceAddress,
            "link": newPlaceLink,
            "phoneNumber": newPlacePhoneNumber
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
