//
//  DetailedViewViewModel.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import Foundation

class DetailedViewViewModel: ObservableObject {
    
    @Published public var recipe: Recipe = Recipe(name: "Test", instructions: [""], ingredients: ["":""])
    
    func fetchDetails(id: String) {
        MealAPI.shared.getFoodDetails(mealid: id) { [self] result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let reciperesponse):
                    //print(reciperesponse)
                    self.recipe = formatResponse(unparsedData: reciperesponse)!
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
    
    func formatResponse(unparsedData: [String:Any]) -> Recipe? {
        let detailResponse = unparsedData["meals"] as? [Any]
        guard let recipeInfo = detailResponse?[0] as? [String:Any] else {
            print("Response included no meals")
            return nil
        }
        
        guard let name = recipeInfo["strMeal"] as? String else {
            print("There is no meal name")
            return nil
        }
        
        var instructions: [String]?
        if let instructionsString = recipeInfo["strInstructions"] as? String {
            let instructionsArray = instructionsString.split(whereSeparator: \.isNewline)
            instructions = instructionsArray.map{
                item in
                return String(item)}
        }
        
        var ingredients = [String:(name: String, measurement: String)]()
        for (key,value) in recipeInfo {
            let ingredientPrefix = "strIngredient"
            let measurementPrefix = "strMeasure"
            
            guard let value = value as? String else {continue}
            let validString = !value.trimmingCharacters(in: .whitespaces).isEmpty
            var keyString = key
            if keyString.hasPrefix(ingredientPrefix) && validString {
                keyString = String(keyString.dropFirst(ingredientPrefix.count))
                ingredients[keyString, default: ("","")].name = value
            } else if keyString.hasPrefix(measurementPrefix) && validString{
                keyString = String(keyString.dropFirst(measurementPrefix.count))
                ingredients[keyString, default: ("","")].measurement = value
            }
        }
        if ingredients.isEmpty || instructions == nil {
            return nil
        }
        var ingredientsDictionary = [String:String]()
        for (key,value) in ingredients.values {
            ingredientsDictionary["\(key)"] = "\(value)"
            //print(key + " \(value)")
        }
        return Recipe(name: name, instructions: instructions, ingredients: ingredientsDictionary)
    }
}
