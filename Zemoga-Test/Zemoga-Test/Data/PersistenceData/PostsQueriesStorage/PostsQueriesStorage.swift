//
//  PostsQueriesStorage.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation

protocol PostsQueriesStorage {
    func fetchRecentsQueries(maxCount: Int,completion: @escaping (Result<[PostQuery], Error>) -> Void)
    func saveRecentQuery(query: PostQuery, completion: @escaping (Result<PostQuery, Error>) -> Void)
}
