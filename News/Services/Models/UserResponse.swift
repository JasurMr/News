//
//  UserResponse.swift
//  News
//
//  Created by Macbook on 9/17/19.
//  Copyright © 2019 iMac GWS. All rights reserved.
//

import Foundation


struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
