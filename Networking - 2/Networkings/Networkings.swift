//
//  Networkings.swift
//  Networking - 2
//
//  Created by Nasim Nozirov on 29.06.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class Networking {
    static let shared = Networking()
    
    private init() { }
    
    func fetchData(from url: String, with completion: @escaping([Image]) -> Void) {
        guard let url = URL(string: url ) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let images = try JSONDecoder().decode([Image].self, from: data)
                DispatchQueue.main.async {
                    completion(images)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
//    func fetchEpisode(from url: String, completion: @escaping(Result<Meal, NetworkError>) -> Void) {
//        guard let url = URL(string: url) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                completion(.failure(.noData))
//                print(error?.localizedDescription ?? "no description")
//                return
//            }
//
//            do {
//                let meal = try JSONDecoder().decode(Meal.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(meal))
//                }
//            } catch {
//                completion(.failure(.decodingError))
//            }
//
//        }.resume()
//    }
//
    func fetchImage(from url: String?, with completion: @escaping(Data) -> Void) {
        guard let stringURL = url else { return }
        guard let imageURL = URL(string: stringURL) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}

