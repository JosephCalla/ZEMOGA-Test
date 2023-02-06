//
//  DefaultUsersRepository.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 6/02/23.
//

import Foundation

final class DefaultUsersRepository {

    private let dataTransferService: DataTransferService
    private let cache: PostsResponseStorage

    init(dataTransferService: DataTransferService, cache: PostsResponseStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension DefaultUsersRepository: UsersRepository {
    func fetchUsers(cached: @escaping ([User]) -> Void, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        let endpoint = APIEndpoints.getUsers()
        
        task.networkTask = self.dataTransferService.request(with: endpoint, completion: { result in
            switch result {
            case .success(let responseDTO):
                    completion(.success(responseDTO.toDomain()))
                
            case .failure(let error):
                print("🚨❌\(error)")
                completion(.failure(error))
            }
        })
        return task
    }}
