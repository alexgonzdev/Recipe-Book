//
//  MockCategories.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 1/12/23.
//

import Foundation


class MockCategoryService: Networking {
    private let jsonString = """
{
  "categories": [
    {
      "strCategory": "Beef",
      "strCategoryThumb": "https://www.themealdb.com/images/category/beef.png",
    }
  ]
}
"""
    
    
    func fetch<T>(completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        
        let jsonData = jsonString.data(using: .utf8)!
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(T.self, from: jsonData)
            completion(.success(decodedResponse))
        } catch {
            print(String(describing: error))
            completion(.failure(.invalidData))
        }
        
    }
}
