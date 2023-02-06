//
//  FetchCommentsPostsUseCase.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 6/02/23.
//

import Foundation

protocol FetchCommentsUseCase {
    func execute(query: CommentRequestDTO, cached: @escaping ([Comment]) -> Void, completion: @escaping (Result<[Comment], Error>) -> Void) -> Cancellable?
}

final class DefaultFetchCommentsUseCase: FetchCommentsUseCase {
    private let postsRepository: PostsRepository
    
    init(postsRepository: PostsRepository) {
        self.postsRepository = postsRepository
    }
    
    func execute(query: CommentRequestDTO, cached: @escaping ([Comment]) -> Void, completion: @escaping (Result<[Comment], Error>) -> Void) -> Cancellable? {
        return postsRepository.fetchComments(query: query, cached: cached) { result in
            if case .success(let success) = result {
                // save data
                print("🙂")
            }   
            if case .failure(let error) = result {
                print("🥹")
                print(error)
            }
            completion(result)
        }
    }
}
