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
}
