//
//  FoodGridView.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import SwiftUI

struct FoodsGridView: View {
    let name: String

    @ObservedObject var viewModel: FoodViewViewModel
    var detailVm = DetailedViewViewModel(networking: Network())
    let gridItem = [GridItem(.fixed(170), spacing: 20),GridItem(.fixed(170), spacing: 20)]
    
    var body: some View {
        ZStack {
            Color(hex: 0x1A1E21).edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVGrid(columns: gridItem) {
                    ForEach(viewModel.meals, id: \.self) { meal in
                        
                        NavigationLink(destination: DetailedView(dessertId: meal.idMeal, imageUrl: meal.strMealThumb, detailViewModel: detailVm)) {
                            
                            CategoryCell(imageURL: meal.strMealThumb, name: meal.strMeal, sizing: 120)
                        }
                        
                    }
                }
            }
                
            
            
            .onAppear() {
                viewModel.fetchFoods(name: name)
            }
        }.navigationTitle(name)
        
        
    }
    
}



