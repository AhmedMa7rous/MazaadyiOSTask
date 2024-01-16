//
//  MockNetworkManager.swift
//  MazaadyiOSTaskTests
//
//  Created by Ahmed Mahrous on 14/01/2024.
//

import XCTest
@testable import MazaadyiOSTask

class MockNetworkManager: NetworkManagerProtocol {

    var result: Result<Categories, APIError>?

    func fetchAllCategories(completion: @escaping (Result<Categories, APIError>) -> Void) {
        if let result = result {
            completion(result)
        } else {
            XCTFail("Result not set for fetchAllCategories in MockNetworkManager")
        }
    }

    func fetchProperties(forCategory categoryId: Int, completion: @escaping (Result<Properties, APIError>) -> Void) {
        // The Same as fetchAllCategories function
    }

    func fetchOptionsChild(forOptionId optionId: Int, completion: @escaping (Result<Models, APIError>) -> Void) {
        // The Same as fetchAllCategories function
    }

    

}
