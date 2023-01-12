//
//  DetailedView.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import SwiftUI
import CachedAsyncImage
struct DetailedView: View {
    var dessertId: String
    var imageUrl: String
    @State var selectedCategory = "Ingredients"
    @ObservedObject var detailViewModel: DetailedViewViewModel
    
    var body: some View {
        
        ZStack {
            Color(hex: 0x1A1E21).edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .center) {
                    Text("\(detailViewModel.recipe.name)")
                        .font(.system(size: 24, weight: .medium,design: .rounded))
                        .foregroundColor(.white)
                        .padding(.bottom)
                    
                    CachedAsyncImage(url: URL(string: imageUrl), transaction: .init(animation: .spring(response: 1.6))) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .progressViewStyle(.circular)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            Text("Failed fetching image. Make sure to check your data connection and try again.")
                                .foregroundColor(.red)
                        @unknown default:
                            Text("Unknown error. Please try again.")
                                .foregroundColor(.red)
                        }
                    }
                    //.resizable()
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)
                    
                    PickerView(selectedCategory: $selectedCategory,labels:  ["Ingredients","Instructions"])
                    
                    if selectedCategory == "Instructions"  {
                        InstructionsStack(instructions: (detailViewModel.recipe.instructions!))
                    }
                    if selectedCategory == "Ingredients"  {
                        IngredientStack(ingredients: (detailViewModel.recipe.ingredients!))
                    }
                    Spacer()
                }
                .onAppear() {
                    detailViewModel.fetchDetails(id: dessertId)
                }
            }
        }
    }
}
