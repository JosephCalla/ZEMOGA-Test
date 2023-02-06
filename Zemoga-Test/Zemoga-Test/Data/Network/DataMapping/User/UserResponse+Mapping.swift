//
//  UserDTO.swift
//  Zemoga-Test
//
//  Created by Joseph Estanislao Calla Moreyra on 2/02/23.
//

import Foundation

struct UserResponseDTO: Codable {
    let id: Int
    let name, username, email: String
    let address: AddressDTO
    let phone, website: String
    let company: CompanyDTO
}

struct AddressDTO: Codable {
    let street, suite, city, zipcode: String
    let geo: GeoDTO
}

struct GeoDTO: Codable {
    let lat, lng: String
}

struct CompanyDTO: Codable {
    let name, catchPhrase, bs: String
}


// MARK: - Comment
// Convert the CommentResponseDTO to Comment (Entity)
extension UserResponseDTO {
    func toDomain() -> User {
        return .init(
            id: id,
            name: name,
            username: username,
            email: email,
            address: Address(
                street: address.street,
                suite: address.suite,
                city: address.city,
                zipcode: address.zipcode,
                geo: Geo(
                    lat: address.geo.lat,
                    lng: address.geo.lng
                )
            ),
            phone: phone,
            website: website,
            company: Company(
                name: company.name,
                catchPhrase: company.catchPhrase,
                bs: company.bs
            )
        )
    }
}


extension Array where Element == UserResponseDTO {
    func toDomain() -> [User] {
        return self.map { $0.toDomain() }
    }
}
