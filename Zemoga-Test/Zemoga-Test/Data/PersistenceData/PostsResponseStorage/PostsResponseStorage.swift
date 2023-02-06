//
//  PostsResponseStorage.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 1/02/23.
//

import Foundation

protocol PostsResponseStorage {
    func save(response: [PostResponseDTO], for requestDto: PostsRequestDTO)
    func getResponse(completion: @escaping (Result<[PostResponseDTO]?, CoreDataStorageError>) -> Void)
}
