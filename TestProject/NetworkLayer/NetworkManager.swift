//
//  NetworkManager.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//  Modified by Eka Kelenjeridze on 24.11.23.
//

import Foundation

final class NetworkManager {
#warning("იმისათვის, რომ ეს property შემდგომში ViewModel-ში გამოყენებული იყოს, არა როგორც NetworkManager-ის ობიექტის ტიპის ინსტანსის property, არამედ, რგოორც NetworkManager ტიპის property, მუდმივას წინ უნდა დავუწეროთ static keyword-ის, რაც მას გარდაქმნის type property-ად.")
    static let shared = NetworkManager()
    
#warning("public-ის ნაცვლად უნდა იყოს private.")
    private init() {}
    
    func get<T: Decodable>(url: String, completion: @escaping ((Result<T, Error>) -> Void)) {
#warning("empty string replaced with url.")
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
#warning("NetworkManager არ უნდა ჰენდლავდეს thread ნაწილს, შესაბამისად წასაშლელია DispatchQueue.main.async.")
            if let error {
                completion(.failure(error))
            }
            
            guard let data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
#warning("აკლდა .resume(), რაც საჭირო იყო task-ის დასაწყებად ანუ API request-ის განსახორციელებლად.")

