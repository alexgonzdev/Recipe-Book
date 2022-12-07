//
//  PickerView.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import SwiftUI

struct PickerView: View {
    @Binding var selectedCategory: String
    let labels: [String]
    
    var body: some View {
        
        VStack {
            HStack(spacing: 10) {
                ForEach(labels, id: \.self) { label in
                    VStack {
                        Text(label).padding(2)
                            .font(.system(size: 22, weight: .semibold, design: .rounded))
                            .foregroundColor((selectedCategory == label) ? Color(hex: 0xFF8C27) : .gray)
                    }
                    .onTapGesture {
                        selectedCategory = label
                    }
                    .padding(2)
                }
            }
        }
    }
}
