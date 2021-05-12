//
//  CollectionViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 5/2/21.
//

import Foundation
import Alamofire
import SwiftUI

class CollectionViewModel: ObservableObject {
    @Published var places = [Place]()
    @Published var loadingPlaces: Bool = false
    @Published var responseMessage = ""


    func getPlacesInCollection(token: String?, collectionId: String?) {
        withAnimation {
            loadingPlaces = true
        }
        let headers: HTTPHeaders = [Headers.AUTH: token ?? ""]
        let parameters = [BodyParams.COLLECTION: collectionId]
        AF.request(
            "\(Routes.GET_PLACES)",
            parameters: parameters,
            headers: headers
        )
        .validate()
        .responseJSON { response in
            print(response)
        }
        .responseDecodable(of: APIResponse.self) { response in
            guard let response = response.value else { print("Cannot parse to Decodables"); return }
            self.places = response.contents?.places ?? [Place]()
            print(self.places)
            withAnimation {
                self.loadingPlaces = false
            }
        }
    }
    
    func deletePlace(token: String?, index: Int, completion: @escaping (Bool) -> Void) {
        
        let placeId = places[index].id
        let headers: HTTPHeaders = [Headers.AUTH: token ?? ""]
        
        let DeleteRoute = "\(Routes.GET_PLACES)/\(placeId)"
        print(DeleteRoute)
        AF.request(DeleteRoute,
            method: .delete,
            headers: headers
        )
        .validate()
        .responseJSON { response in
            print(response)
        }
        .responseDecodable(of: APIResponse.self) { response in
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
            self.places.remove(at: index)
            completion(true)
            
        }

    }
}
