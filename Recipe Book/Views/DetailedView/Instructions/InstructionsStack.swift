//
//  InstructionsStack.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import SwiftUI


struct InstructionsStack: View {
    let instructions: [String]
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            ForEach(instructions, id: \.self) { item in
                InstructionsRow(instruction: item)
                    .background(Color(hex: 0x22282C))
                    .padding(20)
                Divider().overlay(Color.gray.opacity(0.5))
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color(uiColor: .gray), lineWidth: 1)
        )
        .foregroundColor(Color(uiColor: .tertiaryLabel))
        .background(Color(hex: 0x22282C))
        .padding()
    }
}
