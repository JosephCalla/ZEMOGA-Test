//
//  PostsQueryListItemViewModel.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation

class PostsQueryListItemViewModel {
    let query: String

    init(query: String) {
        self.query = query
    }
}

extension PostsQueryListItemViewModel: Equatable {
    static func == (lhs: PostsQueryListItemViewModel, rhs: PostsQueryListItemViewModel) -> Bool {
        return lhs.query == rhs.query
    }
}
