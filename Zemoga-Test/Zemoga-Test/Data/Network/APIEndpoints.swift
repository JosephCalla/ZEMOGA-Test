//
//  APIEndpoints.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 31/01/23.
//

import Foundation

struct APIEndpoints {
    
    static func getPosts() -> Endpoint<[PostResponseDTO]> {

        return Endpoint(path: "posts",
                        method: .get)
    }

    static func getPostsByID(with postsRequestDTO: PostsRequestDTO) -> Endpoint<PostResponseDTO> {

        return Endpoint(path: "/posts/\(postsRequestDTO.id)",
                        method: .get)
    }
    
    static func getCommentsByPostID(with commentRequestDTO: CommentRequestDTO ) -> Endpoint<[CommentResponseDTO]> {

        return Endpoint(path: "posts/\(commentRequestDTO.id)/comments",
                        method: .get)
    }
    
    
    static func getUsersByID(with userRequestDTO: UserRequestDTO) -> Endpoint<UserResponseDTO> {

        return Endpoint(path: "/users/\(userRequestDTO.id)",
                        method: .get)
    }
    
    
    static func getUsers() -> Endpoint<[UserResponseDTO]> {

        return Endpoint(path: "users",
                        method: .get)
    }
    
    static func getPostPoster(path: String, width: Int) -> Endpoint<Data> {

        let sizes = [92, 154, 185, 342, 500, 780]
        let closestWidth = sizes.enumerated().min { abs($0.1 - width) < abs($1.1 - width) }?.element ?? sizes.first!

        return Endpoint(path: "/photos/\(closestWidth)\(path)",
                        method: .get,
                        responseDecoder: RawDataResponseDecoder())
    }
}

