//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Will Chew on 2018-07-13.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        app.navigationBars["Master"].buttons["Add"].tap()
        
        let tablesQuery = app.tables

        
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText("Burger")
        
        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText("300")
        addAMealAlert.buttons["Ok"].tap()
    }
    
    func testDeleteMeal() {
        
        deleteMeal(aName: "Burger", calories: "300")
        
    }
    
    
    func testShowMealDetail() {

       
        showDetail(name: "Burger", calories: "300")

        XCTAssert(app.staticTexts["detailViewControllerLabel"].label == "Burger - 300")
 
        app.navigationBars["Detail"].buttons["Master"].tap()
        
    }
    
    func showDetail(name: String, calories: String) {
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["titleLabel"]/*[[".cells[\"title\"]",".staticTexts[\"title\"]",".staticTexts[\"titleLabel\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        


//        let cellStuff = app.tables.staticTexts["title"]
//
//        let detail = XCUIApplication().staticTexts["detailViewControllerLabel"]
    }
    
    
    func deleteMeal(aName: String, calories: String){
        
        let name = aName
        let calories = calories
        
        let tablesQuery = app.tables
        let staticText = tablesQuery.staticTexts["\(name) - \(calories)"]
        if staticText.exists{
            staticText.swipeLeft()
            tablesQuery.buttons["Delete"].tap()
        }
        
        
        
    }
}
