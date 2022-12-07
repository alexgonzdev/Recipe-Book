//
//  FoodGridView.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import SwiftUI

struct FoodsGridView: View {
    let name: String

    @StateObject private var viewModel = FoodViewViewModel()
    let gridItem = [GridItem(.fixed(170), spacing: 20),GridItem(.fixed(170), spacing: 20)]
    
    var body: some View {
        ZStack {
            Color(hex: 0x1A1E21).edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVGrid(columns: gridItem) {
                    ForEach(viewModel.meals, id: \.self) { meal in
                        
                        NavigationLink(destination: DetailedView(dessertId: meal.idMeal, imageUrl: meal.strMealThumb)) {
                            
                            CategoryCell(imageURL: meal.strMealThumb, name: meal.strMeal, sizing: 120)
                        }
                        
                    }
                }
            }
                
            
            
            .onAppear() {
                viewModel.fetchFoods(name: name)
            }
        }
        
        
    }
    
}



