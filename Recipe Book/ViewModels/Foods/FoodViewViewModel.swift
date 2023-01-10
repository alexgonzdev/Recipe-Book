//
//  FoodViewViewModel.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import Foundation


final class FoodViewViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    
    
    
    func fetchFoods(name: String) {
        Network().fetch(FilterEndpoint(name: name)) { [self] (result: Result<Meals, APIError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meals):
                    print(meals)
                    self.meals = meals.meals
                   // print(self.meals)
                case .failure(let error):
                    print(result)
                    switch error {
                    case .invalidURL:
                        print("There is an error trying to reach the server. If this persists, please contact support.")
                    case .invalidData:
                        print("Unable to complete your request at this time. Please check your internet connection.")
                    case .invalidResponse:
                        print("Invalid response from the server. Please try again or contact support.")
                    case .unableToComplete:
                        print("The data received from the server was invalid. Please try again or contact support.")
                    }
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
