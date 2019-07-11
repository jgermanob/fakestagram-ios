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

class EditPostClient {
    private let client = Client()
    private let path = "/api/posts"
    let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func update(id: Int, payload: CreatePostBase64, succcess: @escaping (Post) -> Void) {
        guard let data = try? encoder.encode(payload) else { return }
        client.request("PATCH", path: "\(path)/\(id)", body: data, completionHandler: { (response, data) in
            if response.successful() {
                guard let data = data else {
                    print("Empty data response")
                    return
                }
                print(data)
                do {
                    let json = try self.decoder.decode(Post.self, from: data)
                    succcess(json)
                } catch let err {
                    print("Error on serialization: \(err.localizedDescription)")
                }
            } else {
                print("Error on response: \(response.rawResponse) - \(response.status)\n\tBody: \(String(describing: data))")
            }
        }, errorHandler: onError(error:))
    }
    
    private func onError(error: Error?) {
        guard let err = error else { return }
        print("Error on request: \(err.localizedDescription)")
    }
}
