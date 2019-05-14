//
//  ProfileClient.swift
//  fakestagram
//
//  Created by Jesús Germán Ortiz Barajas D3 on 5/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class ProfileClient : RestClient<[Post]> {
    convenience init() {
        self.init(client: Client(), path: "/api/profile/posts")
    }
}
