//
//  Recipe.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import Foundation
struct Recipe: Hashable  {
    let name: String
    let instructions: [String]?
    let ingredients: [String:String]?
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.ingredients == rhs.ingredients && lhs.name == rhs.name && lhs.instructions == rhs.instructions
    }
}
