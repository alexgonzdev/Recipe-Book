//
//  CategoryViewViewModel.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import Foundation
final class CategoryViewViewModel: ObservableObject {
    @Published var categories: [Category] = []
    
    
   
    
    func fetchCategories() {
        Network().fetch(CategoryEndpoint()) { [self] (result: Result<CategoriesResponse, APIError>) in
            DispatchQueue.main.async { [self] in
                switch result {
                    
                case .success(let categories):
                
                    //print(categories)
                    self.categories = categories.categories
                case .failure(let error):
                   // print(result)
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
