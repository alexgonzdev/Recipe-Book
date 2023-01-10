//
//  Recipe_BookUITests.swift
//  Recipe BookUITests
//
//  Created by Alex Gonzalez on 12/4/22.
//

import XCTest

final class Recipe_BookUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        
        // Example of passing in launch arguments which can be read in the app
        // by calling CommandLine.arguments.contains("--uitesting")
        // app.launchArguments.append("--uitesting")
        setupSnapshot(app)
        app.launch()
    }
 
    override func tearDownWithError() throws {
        app = nil
    }
 
    func testScreenshot1() throws {
        sleep(10)
        app.buttons.element(boundBy: 1)
        sleep(5)
        snapshot("Content View")
    }
     
    

}
