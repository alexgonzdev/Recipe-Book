//
//  Category.swift
//  Recipe Book
//
//  Created by Alex Gonzalez on 12/4/22.
//

import Foundation


struct Category: Codable, Hashable {
    let name: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strCategory"
        case imageURL = "strCategoryThumb"
        
    }
}


struct CategoriesResponse: Codable {
    let categories: [Category]
}


