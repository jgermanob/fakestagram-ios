//
//  Comment.swift
//  fakestagram
//
//  Created by Jesús Germán Ortiz Barajas on 6/11/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct Comment: Codable{
    let author: Author?
    let id: Int?
    let content: String
    let createdAt: String
    let updatedAt: String
}
