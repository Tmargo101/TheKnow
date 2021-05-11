//
//  AccountViewModel.swift
//  TheKnow
//
//  Created by Tom Margosian on 5/3/21.
//

import Foundation
import Alamofire

class AccountViewModel: ObservableObject {
    @Published var Account: User = User()
    @Published var loadingUser: Bool = false
    
    func getUser (token: String?) {
        loadingUser = true
        let headers: HTTPHeaders = [Headers.AUTH: token ?? ""]
        AF.request(
            Routes.GET_USER,
            headers: headers
        )
        .validate()
        .responseJSON { response in
            print(response)
        }
        .responseDecodable(of: APIResponse.self) { (response) in
            guard let response = response.value else { return }
            self.Account = response.contents?.user ?? User()
            self.loadingUser = false
        }

    }
    
}
