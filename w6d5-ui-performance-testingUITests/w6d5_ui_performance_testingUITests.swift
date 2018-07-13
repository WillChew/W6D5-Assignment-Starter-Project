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
        testDeleteAll()
    }
    
    func testAddMeal() {
        
        app.navigationBars["Master"].buttons["Add"].tap()
        let cellCount = app.tables.staticTexts.count

        
        
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText("Burger")
        
        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText("300")
        addAMealAlert.buttons["Ok"].tap()
        let newCellCount = app.tables.staticTexts.count
        
        
        XCTAssertTrue(cellCount + 1 == newCellCount)
    }
    
    func testDeleteMeal() {
        
        deleteMeal(aName: "Burger", calories: "300")
        
    }
    
    
    func testShowMealDetail() {
        
        showDetail(aName: "Burger", aCalories: "300")
        
        XCTAssert(app.staticTexts["detailViewControllerLabel"].label == "Burger - 300")
        
        app.navigationBars["Detail"].buttons["Master"].tap()
        
    }
    
    func showDetail(aName: String, aCalories: String) {
        
        XCUIApplication().tables/*@START_MENU_TOKEN@*/.staticTexts["titleLabel"]/*[[".cells[\"title\"]",".staticTexts[\"title\"]",".staticTexts[\"titleLabel\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        

    }
    
    
    func deleteMeal(aName: String, calories: String){
        
       
         let cellCount = app.tables.staticTexts.count
        
        let tablesQuery = app.tables
        let titlelabelStaticText = tablesQuery.children(matching: .cell).matching(identifier: "title").element(boundBy: 0)/*@START_MENU_TOKEN@*/.staticTexts["titleLabel"]/*[[".staticTexts[\"title\"]",".staticTexts[\"titleLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/

        if titlelabelStaticText.exists{
            titlelabelStaticText.swipeLeft()
            tablesQuery.buttons["Delete"].tap()
        }
        let newCellCount = app.tables.staticTexts.count
        
       
        
        XCTAssertTrue(cellCount - 1 == newCellCount)
    }
    
    func testDeleteAll() {
        let tablesQuery = app.tables
        
        let cells = XCUIApplication().tables.cells
        
        for _ in cells.allElementsBoundByIndex {
//
        let titlelabelStaticText = tablesQuery.children(matching: .cell).matching(identifier: "title").element(boundBy: 0)/*@START_MENU_TOKEN@*/.staticTexts["titleLabel"]/*[[".staticTexts[\"title\"]",".staticTexts[\"titleLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/

            titlelabelStaticText.swipeLeft()
            tablesQuery.buttons["Delete"].tap()
            }
    }
//        else { return }
//        }
    
    
    func testCoreDataTime() {
        self.measure {
            self.testAddMeal()
            self.testDeleteMeal()
        }
    }
    
    
    
}
