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
    
    @Published var loadingCollections: Bool = false
    @Published var loadingCollection: Bool = false
    @Published var reloadingCollections: Bool = false
    
    func getAllCollections(token: String?, id: String?) {
        withAnimation {
            loadingCollections = true
        }
        reloadingCollections = true
    
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
            guard let response = response.value else { return }
            self.collections = response.contents?.collections ?? []
            withAnimation {
                self.loadingCollections = false
            }
            self.reloadingCollections = false
        }
    }
    
    func getCollection(token: String?, collectionId: String?) {
        loadingCollection = true
        let headers: HTTPHeaders = [Headers.AUTH: token ?? ""]
        AF.request(
            "\(Routes.GET_COLLECTIONS)/\(collectionId ?? "")",
            headers: headers
        )
        .validate()
//        .responseJSON { response in
//            print(response)
//        }
        .responseDecodable(of: APIResponse.self) { response in
            guard let response = response.value else { print("Cannot parse to Decodables"); return }
            self.collection = response.contents?.collection ?? Collection()
//            print(self.collection)
            self.loadingCollection = false
        }
    }
}
