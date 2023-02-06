//
//  DefaultPostsRepository.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 31/01/23.
//

import Foundation

final class DefaultPostsRepository {

    private let dataTransferService: DataTransferService
    private let cache: PostsResponseStorage

    init(dataTransferService: DataTransferService, cache: PostsResponseStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension DefaultPostsRepository: PostsRepository {
    func fetchComments(query: CommentRequestDTO, cached: @escaping ([Comment]) -> Void, completion: @escaping (Result<[Comment], Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        let endpoint = APIEndpoints.getCommentsByPostID(with: query)
        
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
    }
    
    func fetchPosts(cached: @escaping ([Post]) -> Void, completion: @escaping (Result<[Post], Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        
//        guard !task.isCancelled else { return }
        let endpoint = APIEndpoints.getPosts()
        
        task.networkTask = self.dataTransferService.request(with: endpoint, completion: { result in
            switch result {
            case .success(let responseDTO):
                    // Save in coredata :)
//                    self.cache.save(response: responseDTO, for: <#T##PostsRequestDTO#>)
//                print("🚨\(responseDTO)")
                    completion(.success(responseDTO.toDomain()))
                
            case .failure(let error):
                print("🚨❌\(error)")

                completion(.failure(error))
            }
        })
//        cache.getResponse { result in
//            if case let .success(responseDTO?) = result {
//                cached(responseDTO.toDomain())
//            }
//
//            guard !task.isCancelled else { return }
//            let endpoint = APIEndpoints.getPosts()
//
//            task.networkTask = self.dataTransferService.request(with: endpoint, completion: { result in
//                switch result {
//                case .success(let responseDTO):
//                        // Save in coredata :)
////                    self.cache.save(response: responseDTO, for: <#T##PostsRequestDTO#>)
//                    print("🚨\(responseDTO)")
////                    completion(.success(responseDTO.toDomain()))
//
//                case .failure(let error):
//                    print("🚨❌\(error)")
//
//                    completion(.failure(error))
//                }
//            })
//        }
        
        return task
    }
    
    func fetchPostsList(query: PostQuery, page: Int, cached: @escaping (PostsPage) -> Void, completion: @escaping (Result<PostsPage, Error>) -> Void) -> Cancellable? {

        let requestDTO = PostsRequestDTO(id: 1, query: query.query, page: page)
        let task = RepositoryTask()

//        cache.getResponse(for: requestDTO) { result in
//
//            if case let .success(responseDTO?) = result {
////                cached(responseDTO.toDomain())
//            }
//
//            guard !task.isCancelled else { return }
//
//            let endpoint = APIEndpoints.getPosts()
//
//            task.networkTask = self.dataTransferService.request(with: endpoint) { result in
//                switch result {
//                case .success(let responseDTO):
//                    print("🚨")
//                    print(responseDTO)
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        }
        return task
    }
    
    
    func fetchPostsListByID() {
        
    }
}
