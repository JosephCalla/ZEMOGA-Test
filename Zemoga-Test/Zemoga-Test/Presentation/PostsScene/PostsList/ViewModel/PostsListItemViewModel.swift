//
//  PostsListItemViewModel.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 1/02/23.
//

import Foundation

struct PostsListItemViewModel: Equatable {
    let userID: Int
    let id: Int
    let title: String
    let body: String
}

extension PostsListItemViewModel {

    init(post: Post) {
        self.userID = post.userID
        self.id = post.id
        self.title = post.title
        self.body = post.body
    }
}
