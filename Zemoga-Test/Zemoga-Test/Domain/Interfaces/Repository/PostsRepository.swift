//
//  PostsRepository.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 31/01/23.
//

import Foundation
protocol PostsRepository {
    func fetchPostsList(completion: @escaping (Result<[Post], Error>) -> Void)
    func savePosts(completion: @escaping (Result<Post, Error>) -> Void)
}
