//
//  PosterImagesRepository.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 1/02/23.
//

import Foundation

protocol PosterImagesRepository {
    func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable?
}
