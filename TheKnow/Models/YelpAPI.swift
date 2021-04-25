//
//  YelpAPI.swift
//  TheKnow
//
//  Created by Josh Haber on 4/25/21.
//
import Foundation



/*
 https://stackoverflow.com/questions/50609082/how-to-use-yelp-api-v3-in-swift
 Finding specific business by coordinates
 */
fileprivate func fetchYelpBusinesses(latitude: Double, longitude: Double) {
    let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)")
    var request = URLRequest(url: url!)
    request.setValue("Bearer \(YELP_API_KEY)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let err = error {
            print(err.localizedDescription)
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            print(">>>>>", json, #line, "<<<<<<<<<")
        } catch {
            print("caught")
        }
    }.resume()
}

/*
 Finding all locations by location and term
 */
fileprivate func fetchYelpBusinesses(term: String, location: String) {
    let url = URL(string: "https://api.yelp.com/v3/businesses/search?term=\(term)&location=\(location)")
    var request = URLRequest(url: url!)
    request.setValue("Bearer \(YELP_API_KEY)", forHTTPHeaderField: "Authorization")
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let err = error {
            print(err.localizedDescription)
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
            print(">>>>>", json, #line, "<<<<<<<<<")
        } catch {
            print("caught")
        }
    }.resume()
}
