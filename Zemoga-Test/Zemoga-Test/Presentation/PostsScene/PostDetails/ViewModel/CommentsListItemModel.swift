//
//  CommentsListItemModel.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 6/02/23.
//

import Foundation

struct CommentsListItemViewModel: Equatable, Identifiable {
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


extension CommentsListItemViewModel {
    init(comment: Comment) {
        self.postID = comment.postID
        self.id = comment.id
        self.name = comment.name
        self.email = comment.email
        self.body = comment.body
    }
}
