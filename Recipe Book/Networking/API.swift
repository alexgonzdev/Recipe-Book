//
//  NewAPI.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/12/22.
//

import Foundation

protocol APIResource {
    var scheme: String { get }
    var path: String { get }
    var host: String { get }
}
extension APIResource {
    var scheme: String {
        return "https"
    }
    var host: String {
        return "themealdb.com"
    }
}

protocol Networking {
    func fetch<T: Decodable>(_ endpoint: APIResource, completion: @escaping (Result<T, APIError>) -> Void)
}

extension Networking {
    
    
    func fetch<T: Decodable>(_ endpoint: APIResource, completion: @escaping (Result<T, APIError>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let urlString = urlComponents.url?.description else {
            preconditionFailure("Url is not valid")
        }
        guard let url = URL(string: urlString.removingPercentEncoding!) else {
            preconditionFailure("Url is not valid")
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ =  error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                let str = String(decoding: data!, as: UTF8.self)
                completion(.failure(.invalidData))
                return
            }
            
            if endpoint.path.contains("lookup") {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    guard let json = json else {
                        preconditionFailure("Not good json")
                    }
                    
                    completion(.success(formatResponse(unparsedData: json) as! T))
                }
                
                catch{
                    print(String(describing: error))
                    completion(.failure(.invalidData))
                    
                }
                
            }
            
            else {
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    print(String(describing: error))
                    completion(.failure(.invalidData))
                }
                
            }
        }
        task.resume()
    }
}


struct Network: Networking {}

enum Paths: String {
    case lookup = "lookup.php?i="
    case categories = "categories.php"
    case filter = "filter.php?c="
}

enum APIError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
