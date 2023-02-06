//
//  CommentResponse+Mapping.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 2/02/23.
//

import Foundation

struct CommentResponseDTO: Codable {
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


// MARK: - Comment
// Convert the CommentResponseDTO to Comment (Entity)
extension CommentResponseDTO {
    func toDomain() -> Comment {
        return .init(
            postID: postID,
            id: id,
            name: name,
            email: email,
            body: body
        )
    }
}


extension Array where Element == CommentResponseDTO {
    func toDomain() -> [Comment] {
        return self.map { $0.toDomain() }
    }
}
