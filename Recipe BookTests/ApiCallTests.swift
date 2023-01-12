//
//  ApiCallTests.swift
//  Recipe BookTests
//
//  Created by Alex Gonzalez on 12/7/22.
//

import XCTest
@testable import Recipe_Book
final class ApiCallTests: XCTestCase {

    //var viewmodel: DetailedViewViewModel!

       override func setUpWithError() throws {
           // Put setup code here. This method is called before the invocation of each test method in the class.
           //viewmodel = DetailedViewViewModel()
       }

       override func tearDownWithError() throws {
           // Put teardown code here. This method is called after the invocation of each test method in the class.
       }

       func testFormatDataWithInvalidPayload() throws {
           
           var payload = ["1":nil] as [String : Any?]
           
           var formatedData = formatResponse(unparsedData: payload)
           XCTAssertNil(formatedData)
                  
                  
           payload = ["meals":[["" : nil]]] as [String : Any?]
           formatedData = formatResponse(unparsedData: payload)
           XCTAssertNil(formatedData)
           // This is an example of a functional test case.
           // Use XCTAssert and related functions to verify your tests produce the correct results.
           // Any test you write for XCTest can be annotated as throws and async.
           // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
           // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
       }
       
       func testFormatDataWithCorrectPayload() throws {
          
          
           let payload = ["meals":[["idMeal":"52856","strMeal":"Choc Chip Pecan Pie","strDrinkAlternate":nil,"strCategory":"Dessert","strArea":"American","strInstructions":"First, make the pastry.","strMealThumb":"https://www.themealdb.com/images/media/meals/rqvwxt1511384809.jpg","strTags":"Pie,Desert,Sweet,Nutty","strYoutube":"https://www.youtube.com/watch?v=fDpoT0jvg4Y","strIngredient1":"Plain Flour","strMeasure1":"300g","strSource":"https://www.bbcgoodfood.com/recipes/choc-chip-pecan-pie","strImageSource":nil,"strCreativeCommonsConfirmed":nil,"dateModified":nil]]]
           
           var formatedData = formatResponse(unparsedData: payload)
           XCTAssertEqual(formatedData, Recipe(name: "Choc Chip Pecan Pie", instructions: ["First, make the pastry."], ingredients: ["Plain Flour":"300g"]))
           
           
                  
                  
       }

       func testPerformanceExample() throws {
           // This is an example of a performance test case.
           self.measure {
               // Put the code you want to measure the time of here.
           }
       }
    
}
