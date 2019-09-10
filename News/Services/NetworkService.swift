//
//  NetworkService.swift
//  News
//
//  Created by Macbook on 9/5/19.
//  Copyright © 2019 iMac GWS. All rights reserved.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String:String], complation: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    
    let authService: AuthService
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
//    func getFeed() {
//        
//        //https://api.vk.com/method/getProfiles?uid=66748&access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3
//        let params = ["filters":"post,photo"]
//        
//        
//        print(url)
//    }
    
    func request(path: String, params: [String : String], complation: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        let params = ["filters":"post,photo"]
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: path, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, complation: complation)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, complation: @escaping (Data?, Error?)->Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                complation(data, error)
            }
        })
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
    
}
