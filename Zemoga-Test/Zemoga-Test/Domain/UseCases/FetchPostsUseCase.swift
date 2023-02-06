//
//  FetchPostsUseCase.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 5/02/23.
//

import Foundation

protocol FetchPostsUseCase {
    func execute(cached: @escaping ([Post]) -> Void, completion: @escaping (Result<[Post], Error>) -> Void) -> Cancellable?
}

final class DefaultFetchPostsUseCase: FetchPostsUseCase {
    private let postsRepository: PostsRepository
    
    init(postsRepository: PostsRepository) {
        self.postsRepository = postsRepository
    }
    
    func execute(cached: @escaping ([Post]) -> Void, completion: @escaping (Result<[Post], Error>) -> Void) -> Cancellable? {
        return postsRepository.fetchPosts(cached: cached) { result in
            
            if case .success(let success) = result {
                // save data to coredata
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
