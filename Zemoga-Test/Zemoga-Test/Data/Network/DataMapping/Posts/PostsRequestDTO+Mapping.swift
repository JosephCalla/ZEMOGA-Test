//
//  PostRequestDTO+Mapping.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 1/02/23.
//

import Foundation

struct PostsRequestDTO: Encodable {
    let id: Int
    let query: String
    let page: Int
}

