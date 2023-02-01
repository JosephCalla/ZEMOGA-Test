//
//  Album.swift
//  Zemoga-TestTests
//
//  Created by Joseph Estanislao Calla Moreyra on 31/01/23.
//

import Foundation

struct AlbumElement: Codable {
    let userID: Int
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}


//typealias Album = [AlbumElement]
