//
//  Properties.swift
//  MazaadyiOSTask
//
//  Created by Ahmed Mahrous on 13/01/2024.
//

import Foundation

// MARK: - Properties
struct Properties: Codable {
    let code: Int
    let msg: String
    let data: [Property]
}

// MARK: - Datum
struct Property: Codable {
    let id: Int
    let name, slug: String
    let options: [Option]
}

// MARK: - Option
struct Option: Codable {
    let id: Int
    let name, slug: String
}
