//
//  PostsRepository.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 31/01/23.
//

import Foundation
protocol PostsRepository {
    @discardableResult
    func fetchPostsList(query: PostQuery, page: Int,
                        cached: @escaping (PostsPage) -> Void,
                        completion: @escaping (Result<PostsPage, Error>) -> Void) -> Cancellable?
    func fetchPosts(cached: @escaping ([Post]) -> Void, completion: @escaping (Result<[Post], Error>) -> Void) -> Cancellable?
    func fetchComments(query: CommentRequestDTO, cached: @escaping ([Comment]) -> Void, completion: @escaping (Result<[Comment], Error>) -> Void) -> Cancellable?
}


protocol PostsQueriesRepository {
    func fetchRecentsQueries(maxCount: Int,completion: @escaping (Result<[PostQuery], Error>) -> Void)
    func saveRecentQuery(query: PostQuery, completion: @escaping (Result<PostQuery, Error>) -> Void)
}


