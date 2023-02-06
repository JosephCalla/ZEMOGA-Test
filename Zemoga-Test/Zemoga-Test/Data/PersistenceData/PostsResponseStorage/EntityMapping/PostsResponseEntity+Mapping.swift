//
//  PostsResponseEntity+Mapping.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation
import CoreData


// Extensión que permite convertir un DTO a una entidad
extension PostResponseEntity {
    func toDTO() -> PostResponseDTO {
        return .init(
            userID: Int(userID),
            id: Int(id),
            title: title ?? "No title",
            body: body ?? "No body"
        )
    }
}

