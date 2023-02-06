//
//  FetchPostsUseCase.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 31/01/23.
//

import Foundation

final class FetchRecentPostQueriesUseCase: UseCase {

    struct RequestValue {
        let maxCount: Int
    }
    typealias ResultValue = (Result<[PostQuery], Error>)

    private let requestValue: RequestValue
    private let completion: (ResultValue) -> Void
    private let postsQueriesRepository: PostsQueriesRepository

    init(requestValue: RequestValue,
         completion: @escaping (ResultValue) -> Void,
         postsQueriesRepository: PostsQueriesRepository) {

        self.requestValue = requestValue
        self.completion = completion
        self.postsQueriesRepository = postsQueriesRepository
    }
    
    func start() -> Cancellable? {
        postsQueriesRepository.fetchRecentsQueries(maxCount: requestValue.maxCount, completion: completion)
        return nil
    }
}
