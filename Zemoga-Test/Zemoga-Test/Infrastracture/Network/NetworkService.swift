//
//  NetworkService.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 31/01/23.
//

import Foundation

public enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}


public protocol NetworkCancellable {
    func cancel()
}
