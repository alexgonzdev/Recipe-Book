//
//  IngredientRow.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import SwiftUI


struct IngredientRow: View {
    let ingredient: Ingredient
    var body: some View {
        HStack {
            Text(ingredient.name.capitalized)
                .font(.system(size: 18, weight: .regular,design: .rounded))
                .foregroundColor(.white)
            Spacer()
            Text(ingredient.measurement.capitalized)
                .font(.system(size: 18, weight: .regular,design: .rounded))
                .foregroundColor(.white)
                .padding(.trailing)
        }
        
        
    }
}
