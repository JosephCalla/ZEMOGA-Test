//
//  Comment.swift
//  Zemoga-TestTests
//
//  Created by Joseph Estanislao Calla Moreyra on 31/01/23.
//

import Foundation

struct Comment: Equatable, Identifiable {
    let postID: Int
    let id: Int
    let name: String
    let email: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}
