//
//  CommentClient.swift
//  fakestagram
//
//  Created by Jesús Germán Ortiz Barajas on 6/11/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct CreateComment: Codable {
    let content: String
}

class CommentClient : RestClient<[Comment]> {
    convenience init(post : Post) {
        self.init(client: Client(), path: "/api/posts/\(post.id!)/comments")
    }
}

class CreateCommentClient : RestClient<CreateComment>{
    convenience init(post: Post) {
        self.init(client: Client(), path: "/api/posts/\(post.id!)/comments")
    }
}


