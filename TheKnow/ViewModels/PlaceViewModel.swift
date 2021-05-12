//
//  PlaceViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 5/11/21.
//

import Foundation
import Alamofire

class PlaceViewModel: ObservableObject {
    @Published var place = Place()
    @Published var loadingPlace: Bool = false
    
    func getPlace(token: String?, placeId: String) {
        self.loadingPlace = true
        let headers: HTTPHeaders = [Headers.AUTH: token ?? ""]
        AF.request(
            "\(Routes.GET_PLACE)/\(placeId)",
            headers: headers
        )
        .validate()
        .responseJSON { response in
            print(response)
        }
        .responseDecodable(of: APIResponse.self) { response in
//            guard let response = response.value else { print("Cannot parse to Decodables"); return }
//            self.place = response.contents?.places ?? Place()
            print(self.place)
            self.loadingPlace = false
        }
    }
}
