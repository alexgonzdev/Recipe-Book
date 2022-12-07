//
//  FoodViewViewModel.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import Foundation


final class FoodViewViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isLoading = false
    
    
    func fetchFoods(name: String) {
        MealAPI.shared.getFoods(name:name) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let meals):
                    self.meals = meals
                   // print(self.meals)
                    
                case .failure(let error):
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
