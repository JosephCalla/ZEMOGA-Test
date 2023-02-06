//
//  DefaultPostsQueriesRepository.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 3/02/23.
//

import Foundation

final class DefaultPostsQueriesRepository {
    
    private let dataTransferService: DataTransferService
    private var postsQueriesPersistentStorage: PostsQueriesStorage
    
    init(dataTransferService: DataTransferService,
         postsQueriesPersistentStorage: PostsQueriesStorage) {
        self.dataTransferService = dataTransferService
        self.postsQueriesPersistentStorage = postsQueriesPersistentStorage
    }
}

extension DefaultPostsQueriesRepository: PostsQueriesRepository {
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[PostQuery], Error>) -> Void) {
        return postsQueriesPersistentStorage.fetchRecentsQueries(maxCount:  maxCount, completion: completion)
    }
    
    func saveRecentQuery(query: PostQuery, completion: @escaping (Result<PostQuery, Error>) -> Void) {
        postsQueriesPersistentStorage.saveRecentQuery(query: query, completion: completion)
    }
}
