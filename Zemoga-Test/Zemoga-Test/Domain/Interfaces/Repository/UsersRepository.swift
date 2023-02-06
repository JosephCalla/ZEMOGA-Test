//
//  UsersRepository.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 6/02/23.
//

import Foundation

protocol UsersRepository {
    @discardableResult
    func fetchUsers(cached: @escaping ([User]) -> Void, completion: @escaping (Result<[User], Error>) -> Void) -> Cancellable?
}
