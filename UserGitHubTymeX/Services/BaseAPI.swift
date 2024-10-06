//
//  BaseAPI.swift
//  UserGitHubTymeX
//
//  Created by Hổ's Macbook on 05/10/2024.
//

import Foundation


/// BaseAPI is a singleton class that handles network requests to the GitHub API.
///
/// It provides a centralized way to make API calls, handling URL construction,
/// HTTP methods, parameters, and response parsing.
///
/// Key features:
/// - Singleton instance for global access
/// - Configurable base URL
/// - Support for GET and other HTTP methods
/// - Automatic JSON decoding of responses
/// - Error handling for network and parsing issues
///
/// Usage:
/// Call `BaseAPI.shared.request(...)` to make API requests.
class BaseAPI {
    static let shared = BaseAPI()
    private let baseUrl = "https://api.github.com"
    private let session = URLSession.shared
    
    private init() {}
    
    /// Performs an HTTP request to the specified endpoint and decodes the response.
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    ///   - method: The HTTP method (default is "GET").
    ///   - parameters: Optional query parameters or body data.
    ///   - completion: A closure called with the result (decoded data or error).
    ///
    /// - Returns: Void
    func request<T: Decodable>(_ endpoint: String, method: String = "GET", parameters: [String: Any]? = nil, completion: @escaping (Result<T, Error>) -> Void) {
        var urlComponents = URLComponents(string: baseUrl + endpoint)
        
        if let parameters = parameters, method == "GET" {
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        
        guard let url = urlComponents?.url else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        if let parameters = parameters, method != "GET" {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        /// Executes the network request and handles the response.
        ///
        /// - Performs the data task with the configured request
        /// - Handles potential errors from the network call
        /// - Decodes the received data into the specified type
        /// - Calls the completion handler with the result
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}