//
//  UseCases.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 31/01/23.
//

import Foundation

public protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
