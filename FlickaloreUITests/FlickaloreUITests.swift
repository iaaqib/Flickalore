//
//  FlickaloreUITests.swift
//  FlickaloreUITests
//
//  Created by Aaqib Hussain on 25/7/18.
//  Copyright © 2018 Aaqib Hussain. All rights reserved.
//

import XCTest

class FlickaloreUITests: XCTestCase {
    
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

    }

    func testAppFlow() {

        let cell = app.cells["imageCell"]
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        app.swipeUp()
        app.cells.element(boundBy: 10).tap()
        XCTAssertTrue(app.scrollViews["zoomScrollView"].exists)
        app.buttons["backButton"].tap()
        XCTAssertTrue(app.cells["imageCell"].exists)
        app.tabBars.buttons.element(boundBy: 1).tap()
        app.cells.element(boundBy: 5).tap()
        XCTAssertTrue(app.scrollViews["zoomScrollView"].exists)
        app.buttons["backButton"].tap()
        app.swipeUp()
        app.swipeUp()
        app.cells.element(boundBy: 9).tap()
        XCTAssertTrue(app.scrollViews["zoomScrollView"].exists)
        app.buttons["backButton"].tap()
        app.tabBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.cells["imageCell"].exists)
    }
    
}
