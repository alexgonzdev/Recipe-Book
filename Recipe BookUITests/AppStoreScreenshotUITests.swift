//
//  AppStoreScreenshotUITests.swift
//  Recipe BookUITests
//
//  Created by Alex Gonzalez on 12/5/22.
//
import XCTest
final class AppStoreScreenshotUITests: XCTestCase {
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
        app.buttons.element(boundBy: 2).tap()
        sleep(5)
        app.buttons.element(boundBy: 5).tap()
        sleep(5)
        snapshot("Content View")
    }
     
     
}
