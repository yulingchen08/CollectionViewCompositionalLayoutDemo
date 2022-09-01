//
//  NetworkService.swift
//  CollectionViewCompositionalLayoutDemo
//
//  Created by 陳鈺翎 on 2022/9/1.
//

import Foundation



class NetworkService: NSObject {
    static let shared = NetworkService.init()
    
    
    func login() {
        let url = URL.init(string: "https://api.pexels.com/v1/search?query=arenas1225@hotmail.com")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Authorization", forHTTPHeaderField: "563492ad6f9170000100000148b1f14dcf6d49e5b4a3a244e310a764")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("[Error] Login failed: \(error)")
            } else {
                print("[Success] Login")
            }
        }.resume()
    }
    //563492ad6f9170000100000148b1f14dcf6d49e5b4a3a244e310a764
    
    
    func requestCollections() {
        let url = URL.init(string: "https://api.pexels.com/v1/collections/featured")!
        var request = URLRequest.init(url: url)
        let headers = [
            "Authorization": "563492ad6f9170000100000148b1f14dcf6d49e5b4a3a244e310a764",
            "Content-Type": "application/json"
        ]
        request.httpMethod = "GET"
        //request.setValue("Authorization", forHTTPHeaderField: "563492ad6f9170000100000148b1f14dcf6d49e5b4a3a244e310a764")
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("[Error] requestCollections failed: \(error)")
                return
            }
            print("[Success] requestCollections")
            if let res = response as? HTTPURLResponse {
                print("status code: \(res.statusCode)")
            }
            
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let featuredCollection = try decoder.decode(FeaturedCollection.self, from: data)
                    print("featuredCollection: \(featuredCollection)")
                } catch {
                    print("Decode failed: \(error)")
                }
            }
            
        }.resume()
    }
    
    
}





extension NetworkService: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!) )
        }
}
