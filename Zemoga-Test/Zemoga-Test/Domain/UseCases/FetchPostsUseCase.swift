//
//  FetchPostsUseCase.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 31/01/23.
//

import Foundation
final class FetchPostsUseCase: UseCase {

    struct RequestValue {
        let maxCount: Int
    }
    typealias ResultValue = (Result<[Post], Error>)

    private let requestValue: RequestValue
    private let completion: (ResultValue) -> Void
    private let postsRepository: PostsRepository

    init(requestValue: RequestValue,
         completion: @escaping (ResultValue) -> Void,
         postsRepository: PostsRepository) {

        self.requestValue = requestValue
        self.completion = completion
        self.postsRepository = postsRepository
    }
    
    func start() -> Cancellable? {
        postsRepository.fetchPostsList(completion: completion)
        return nil
    }
}
