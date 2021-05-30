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
    @Published var responseMessage = ""
    
    @Published var collection = Collection()
    @Published var loadingCollection: Bool = true
    
    func getCollection(token: String?, collectionId: String?, completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [Headers.AUTH: token ?? ""]
        AF.request(
            "\(Routes.GET_COLLECTIONS)/\(collectionId ?? "")",
            headers: headers
        )
        .validate()
        .responseDecodable(of: APIResponse.self) { [self] response in
            guard let response = response.value else {
                completion(false)
                return
            }
            self.collection = response.contents?.collection ?? Collection()
            completion(true)
        }
    }

    func getPlacesInCollection(token: String?, collectionId: String?, completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [Headers.AUTH: token ?? ""]
        let parameters = [BodyParams.COLLECTION: collectionId]
        AF.request(
            "\(Routes.GET_PLACES)",
            parameters: parameters,
            headers: headers
        )
        .validate()
        .responseDecodable(of: APIResponse.self) { response in
            guard let response = response.value else {
                print("Cannot parse to Decodables")
                completion(false)
                return
            }
            self.places = response.contents?.places ?? [Place]()
            completion(true)
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
