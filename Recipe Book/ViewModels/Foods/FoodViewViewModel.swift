//
//  FoodViewViewModel.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import Foundation



final class FoodViewViewModel: ObservableObject {
    private var network: Networking

    init(networking: Networking) {
        network = networking
    }
    @Published var meals: [Meal] = []
    func fetchFoods(name: String) {
        network.fetch(FilterEndpoint(name: name)) { [self] (result: Result<Meals, APIError>) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let categories):
                    //print(categories)
                    self.meals = categories.meals
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
   
}


struct FilterEndpoint: APIResource {
    var name: String?
    var path: String {
        guard let name = name else {
            preconditionFailure("name is required")
        }
        return "/api/json/v1/1/filter.php?c=\(name)"
    }
}
