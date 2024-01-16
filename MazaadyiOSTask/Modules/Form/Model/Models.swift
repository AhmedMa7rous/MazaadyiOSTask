//
//  Models.swift
//  MazaadyiOSTask
//
//  Created by Ahmed Mahrous on 14/01/2024.
//

import Foundation

// MARK: - Models
struct Models: Codable {
    let code: Int
    let msg: String
    let data: [Model]
}

// MARK: - Datum
struct Model: Codable {
    let id: Int
    let name: String
    let slug: String
    let type: JSONNull?
    let options: [Option]
}


// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

