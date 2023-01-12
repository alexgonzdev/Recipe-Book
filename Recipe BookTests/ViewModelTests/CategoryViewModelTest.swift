//
//  CategoryViewModelTest.swift
//  Recipe BookTests
//
//  Created by Alex Gonzalez on 1/12/23.
//
import XCTest
@testable import Recipe_Book
import Foundation


class CategoryViewModelTest: XCTestCase {
    
    func test_Category_Mock_Request() async throws {
        let mock = MockCategoryService()
        let categoryVm = CategoryViewModel(networking: mock)
        
        mock.fetch() { [self] (result: Result<CategoriesResponse, APIError>) in
            
            switch result {
            case .success:
                print("Everything went well!")
                
            case .failure(let error):
                XCTFail(error.localizedDescription)
                
            }
        }
    }
}
