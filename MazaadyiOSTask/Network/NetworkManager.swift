//
//  NetworkManager.swift
//  MazaadyiOSTask
//
//  Created by Ahmed Mahrous on 12/01/2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchAllCategories(completion: @escaping (Result<Categories, APIError>) -> Void)
    func fetchProperties(forCategory categoryId: Int, completion: @escaping (Result<Properties, APIError>) -> Void)
    func fetchOptionsChild(forOptionId optionId: Int, completion: @escaping (Result<Models, APIError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {

    static let shared = NetworkManager()

    private let baseURL = "https://staging.mazaady.com/api/v1"
    private let privateKey = "3%o8i}_;3D4bF]G5@22r2)Et1&mLJ4?$@+16"

    private init() {}

    // MARK: - Generic function for making API requests

    private func makeRequest<T: Decodable>(urlString: String, method: String, parameters: [String: Any]?, completion: @escaping (Result<T, APIError>) -> Void) {
        var urlStringWithParams = baseURL + urlString
        // Add parameters to the request if needed
        if let parameters = parameters {
            var queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                queryItems.append(queryItem)
            }
            
            var urlComponents = URLComponents(string: urlStringWithParams)!
            urlComponents.queryItems = queryItems
            urlStringWithParams = urlComponents.url!.absoluteString
        }
        
        guard let url = URL(string: urlStringWithParams) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue(privateKey, forHTTPHeaderField: "private-key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }

        task.resume()
    }

    // MARK: - API Endpoints

    func fetchAllCategories(completion: @escaping (Result<Categories, APIError>) -> Void) {
        makeRequest(urlString: "/get_all_cats", method: "GET", parameters: nil, completion: completion)
    }

    func fetchProperties(forCategory categoryId: Int, completion: @escaping (Result<Properties, APIError>) -> Void) {
        let parameters = ["cat": categoryId]
        makeRequest(urlString: "/properties", method: "GET", parameters: parameters, completion: completion)
    }

    func fetchOptionsChild(forOptionId optionId: Int, completion: @escaping (Result<Models, APIError>) -> Void) {
        makeRequest(urlString: "/get-options-child/\(optionId)", method: "GET", parameters: nil, completion: completion)
    }
}
