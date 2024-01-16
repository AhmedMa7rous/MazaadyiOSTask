//
//  Categories.swift
//  MazaadyiOSTask
//
//  Created by Ahmed Mahrous on 12/01/2024.
//

import Foundation

// MARK: - Categories
struct Categories: Codable {
    let code: Int
    let msg: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
    let slug: String
    let children: [Category]?
}
