//
//  PostsResponseDTO+Mapping.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 1/02/23.
//

import Foundation
struct PostResponseDTO: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}


// MARK: - Mappings to Domain (Send to Domain)
// Converts the PostResponseDTO object to a Post object.
extension PostResponseDTO {
    func toDomain() -> Post {
        return .init(
            userID: userID,
            id: Post.Identifier(id),
            title: title,
            body: body,
            posterPath: nil
        )
    }
}

//Converts the array of PostResponseDTO objects to an array of Post objects.
extension Array where Element == PostResponseDTO {
    func toDomain() -> [Post] {
        return self.map { $0.toDomain() }
    }
}

