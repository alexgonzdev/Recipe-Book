//
//  Meals.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import Foundation

// MARK: - Meals
struct Meals: Codable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Codable, Identifiable, Hashable {
    let id: String = UUID().uuidString
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
    
    enum CodingKeys: String, CodingKey {
        case id, strMeal, strMealThumb, idMeal
        
    }
}
