//
//  Post.swift
//  Zemoga-TestTests
//
//  Created by Joseph Estanislao Calla Moreyra on 31/01/23.
//

import Foundation

struct Post: Codable {
    let userID: Int
    let id: Int
    let title: Int
    let body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

//typealias Posts = [Post]
