//
//  API.swift
//  News
//
//  Created by Macbook on 9/5/19.
//  Copyright © 2019 iMac GWS. All rights reserved.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.101"
    
    static let newsFeed = "/method/newsfeed.get"
    static let newsUser = "/method/users.get"
}
