//
//  PostQueryEntity+Mapping.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation
import CoreData

extension PostQueryEntity {
    convenience init(postQuery: PostQuery, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        query = postQuery.query
        createdAt = Date()
    }
}

extension PostQueryEntity {
    func toDomain() -> PostQuery {
        return .init(query: query ?? "")
    }
}
