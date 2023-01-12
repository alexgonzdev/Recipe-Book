//
//  ContentView.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import SwiftUI

struct ContentView: View {
    
    var categoryVM = CategoryViewModel(networking: Network())
    var body: some View {
        CategoryView(viewModel: categoryVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
