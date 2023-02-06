//
//  SearchPostsUseCase.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 1/02/23.
//

import Foundation

protocol SearchPostsUseCase {
    func execute(requestValue: SearchPostsUseCaseRequestValue,
                 cached: @escaping (PostsPage) -> Void,
                 completion: @escaping (Result<PostsPage, Error>) -> Void) -> Cancellable?
}

final class DefaultSearchPostsUseCase: SearchPostsUseCase {

    private let postsRepository: PostsRepository
    private let postsQueriesRepository: PostsQueriesRepository

    init(postsRepository: PostsRepository,
         postsQueriesRepository: PostsQueriesRepository) {

        self.postsRepository = postsRepository
        self.postsQueriesRepository = postsQueriesRepository
    }

    func execute(requestValue: SearchPostsUseCaseRequestValue,
                 cached: @escaping (PostsPage) -> Void,
                 completion: @escaping (Result<PostsPage, Error>) -> Void) -> Cancellable? {

        return postsRepository.fetchPostsList(query: requestValue.query,
                                                page: requestValue.page,
                                                cached: cached,
                                                completion: { result in

            if case .success = result {
                self.postsQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
            }

            completion(result)
        })
    }
}

struct SearchPostsUseCaseRequestValue {
    let query: PostQuery
    let page: Int
}
