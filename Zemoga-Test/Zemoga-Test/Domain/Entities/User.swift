//
//  User.swift
//  Zemoga-TestTests
//
//  Created by Joseph Estanislao Calla Moreyra on 31/01/23.
//

import Foundation

struct User: Identifiable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
}

// MARK: - Address
struct Address {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo {
    let lat, lng: String
}

// MARK: - Company
struct Company {
    let name, catchPhrase, bs: String
}

