//
//  WebImageView.swift
//  News
//
//  Created by Macbook on 9/7/19.
//  Copyright © 2019 iMac GWS. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {

    private var currentUrlString: String?
    
    func set(imageUrl: String?)  {
        currentUrlString = imageUrl
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else { return }
        
        if let cacheResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cacheResponse.data)
            print("from cache")
            return
        }
        print("from internet")
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.handleLodedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLodedImage(data: Data, response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: urlResponse))
        
        if urlResponse.absoluteString == currentUrlString {
            self.image = UIImage(data: data)
        }
    }

}
