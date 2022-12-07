//
//  API.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//



import Foundation

class MealAPI {
    
    static let shared = MealAPI()
    
    //private override init() {}
    
    
    func getFoods(name: String, completed: @escaping (Result<[Meal], APIError>) -> Void) {
            guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(name)") else {
                completed(.failure(.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let _ =  error {
                    completed(.failure(.unableToComplete))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completed(.failure(.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    let str = String(decoding: data!, as: UTF8.self)
                    completed(.failure(.invalidData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(Meals.self, from: data)
                    completed(.success(decodedResponse.meals))
                } catch {
                    print(String(describing: error))
                    completed(.failure(.invalidData))
                }
            }
            task.resume()
        }
    func getCategories(completed: @escaping (Result<[Category], APIError>) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else {
            completed(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ =  error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                let str = String(decoding: data!, as: UTF8.self)
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(CategoriesResponse.self, from: data)
                completed(.success(decodedResponse.categories))
            } catch {
                print(String(describing: error))
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func getFoodDetails(mealid: String, completed: @escaping (Result<[String : Any], APIError>) -> Void) {
            guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealid)") else {
                completed(.failure(.invalidURL))
                return
            }
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                
                if let _ =  error {
                    completed(.failure(.unableToComplete))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completed(.failure(.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    let str = String(decoding: data!, as: UTF8.self)
                    
                    completed(.failure(.invalidData))
                    return
                }
                
                do {
                    if let responseData: [String:Any] = try (JSONSerialization.jsonObject(with: data) as? [String : Any]) {
                        completed(.success(responseData))
                        
                    }
                } catch {
                    print(String(describing: error))
                    completed(.failure(.invalidData))
                }
            }
            task.resume()
        }
    
    
    
}

