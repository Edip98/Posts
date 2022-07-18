//
//  NetworkManager.swift
//  Posts
//
//  Created by Эдип on 14.07.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
    
    func getPosts(completed: @escaping (Result<PoststsModel, ErrorMessage>) -> Void) {
        
        guard let url = URL(string: baseUrl) else { return }
        
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
                let posts = try decoder.decode(PoststsModel.self, from: data)
                completed(.success(posts))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getPostInfo(by id: Int, completed: @escaping (Result<DetailsModel, ErrorMessage>) -> Void) {
        
        guard let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(id).json") else { return }
        
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
                let details = try decoder.decode(DetailsModel.self, from: data)
                completed(.success(details))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
