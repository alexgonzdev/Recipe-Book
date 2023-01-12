//
//  Grid.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import SwiftUI
struct CategoryView: View {
    @ObservedObject var viewModel: CategoryViewModel
    
    
    let gridItem = [GridItem(.fixed(170), spacing: 20),GridItem(.fixed(170), spacing: 20)]
    
    var body: some View {
        
            NavigationView {
                ZStack {
                    Color(hex: 0x1A1E21).edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVGrid(columns: gridItem) {
                        ForEach(viewModel.categories, id: \.self) { category in
                            NavigationLink(destination: FoodsGridView(name: category.name)) {
                                CategoryCell(imageURL: category.imageURL, name: category.name, sizing: 110)
                            }
                        }
                    }
                }
            }
                .onAppear(perform: viewModel.fetchCategories)
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
        }
            .accentColor(.white)
    }
    
        
}





