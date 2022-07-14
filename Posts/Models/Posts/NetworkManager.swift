//
//  NetworkManager.swift
//  Posts
//
//  Created by Эдип on 14.07.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getPost(completed: @escaping (Result<DataSource, ErrorMessage>) -> Void) {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
 
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let posts = try decoder.decode(DataSource.self, from: data)
                completed(.success(posts))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
