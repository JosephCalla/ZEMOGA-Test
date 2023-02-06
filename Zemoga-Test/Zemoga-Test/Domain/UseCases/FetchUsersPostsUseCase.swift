//
//  FetchUsersPostsUseCase.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 6/02/23.
//

import Foundation


protocol FetchUsersUseCase {
    func execute(cached: @escaping ([User]) -> Void, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable?
}

final class DefaultFetchUsersUseCase: FetchUsersUseCase {
    private let usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
    
    func execute(cached: @escaping ([User]) -> Void, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {
        return usersRepository.fetchUsers(cached: cached) { result in
            
            if case .success(let success) = result {
                // save data
//                self.postsRepository.
//                print(success)
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
