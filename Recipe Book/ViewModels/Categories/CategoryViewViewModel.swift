//
//  CategoryViewModel.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import Foundation
final class CategoryViewModel: ObservableObject {
    
    private var network: Networking
    
    init(networking: Networking) {
        network = networking
    }
    @Published var categories: [Category] = []
    func fetchCategories() {
        network.fetch(CategoryEndpoint()) { [self] (result: Result<CategoriesResponse, APIError>) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let categories):
                    //print(categories)
                    self.categories = categories.categories
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
     
}
struct CategoryEndpoint: APIResource {
    var path: String {
        return "/api/json/v1/1/categories.php"
    }
}
