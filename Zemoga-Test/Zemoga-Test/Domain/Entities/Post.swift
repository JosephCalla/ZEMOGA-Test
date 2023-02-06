//
//  Post.swift
//  Zemoga-TestTests
//
//  Created by Joseph Estanislao Calla Moreyra on 31/01/23.
//

import Foundation

struct Post: Equatable, Identifiable {
    typealias Identifier = Int
    let userID: Int
    let id: Identifier
    let title: String
    let body: String
    let posterPath: String?
}


struct PostsPage: Equatable {
    let page: Int
    let totalPages: Int
    let movies: [Post]
}
