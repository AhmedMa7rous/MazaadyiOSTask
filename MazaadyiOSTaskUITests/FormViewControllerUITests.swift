//
//  FormViewControllerTests.swift
//  MazaadyiOSTaskTests
//
//  Created by Ahmed Mahrous on 14/01/2024.
//

import XCTest

class FormViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testSubmitButtonTapped() throws {
        // Assuming you have accessibility identifiers set for your UI elements
        let categoriesDropDown = app.textFields["Category"]
        let subCategoryDropDown = app.textFields["Subcategory"]
        let processTypeDropDown = app.textFields["Process Type"]
        let brandDropDown = app.textFields["Brand"]
        let modelDropDown = app.textFields["Model"]
        let typeDropDown = app.textFields["Type"]
        let transmissionDropDown = app.textFields["Transmission Type"]
        let submitButton = app.buttons["Submit"]

        // Interaction with UI elements
        categoriesDropDown.tap()
        app.tables.staticTexts["CARS , MOTORCYCLES & ACCESSORIES"].tap()

        subCategoryDropDown.tap()
        app.tables.staticTexts["Cars"].tap()

        processTypeDropDown.tap()
        app.tables.staticTexts["Sell"].tap()

        brandDropDown.tap()
        app.tables.staticTexts["ACURA"].tap()

        modelDropDown.tap()
        app.tables.staticTexts["1.6EL"].tap()

        transmissionDropDown.tap()
        app.tables.staticTexts["Automatic"].tap()

        submitButton.tap()

        // Assert your expected results after the submit button is tapped
        XCTAssertTrue(app.alerts["Submitted"].exists)
        app.alerts["Submitted"].buttons["OK"].tap()
    }
}
