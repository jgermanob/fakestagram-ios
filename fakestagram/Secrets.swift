//
//  Secrets.swift
//  fakestagram
//
//  Created by LuisE on 3/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import SAMKeychain

enum Secrets {
    case host
    case token

    var value: String? {
        switch self {
        case .host:
            return "https://fakestagram-api.herokuapp.com/"
        case .token:
            return UserDefaults.standard.string(forKey: "com.3zcurdia.fakestagram.uuid")
        }
    }

    func set(value: String) -> Bool {
        switch self {
        case .token:
            UserDefaults.standard.set(value, forKey: "com.3zcurdia.fakestagram.uuid")
            return true
        default:
            return false
        }
    }
}
