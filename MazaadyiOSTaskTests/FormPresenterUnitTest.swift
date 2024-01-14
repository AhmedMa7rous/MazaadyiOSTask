//
//  FormPresenter.swift
//  MazaadyiOSTaskTests
//
//  Created by Ahmed Mahrous on 14/01/2024.
//

import XCTest
@testable import MazaadyiOSTask

class FormPresenterTests: XCTestCase {

    var presenter: FormPresenter!
    var mockNetworkManager: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        presenter = FormPresenter(formView: nil, networkManager: mockNetworkManager)
    }
    // MARK: - Fetch Main Categories Tests

    func testFetchMainCategoriesSuccess() {
        // Given
        let mockCategories = Categories(code: 200, msg: "Success", data: DataClass(categories: [Category(id: 1, name: "Category1", slug: "category1", children: nil)]))
        mockNetworkManager.result = .success(mockCategories)
        
        // When
        presenter.fetchMainCategories()
        
        // Then
        XCTAssertEqual(presenter.mainCategories.count, 1)
    }

    func testFetchMainCategoriesFailure() {
        // Given
        mockNetworkManager.result = .failure(.invalidURL)
        
        // When
        presenter.fetchMainCategories()
        
        // Then
        XCTAssertEqual(presenter.mainCategories.count, 1)
    }

    // Add similar tests for fetchProperties, fetchOptionsChild, and getAllSelectedData

    // MARK: - Helper Methods

    // Add any additional helper methods if needed

}

//class FormPresenterTests: XCTestCase {
//
//    var formPresenter: FormPresenter!
//    var mockFormView: MockFormView!
//
//    override func setUp() {
//        super.setUp()
//        mockFormView = MockFormView()
//        formPresenter = FormPresenter(formView: mockFormView)
//    }
//
//    override func tearDown() {
//        formPresenter = nil
//        mockFormView = nil
//        super.tearDown()
//    }
//
//    // Test case 1: Check if fetching main categories updates form view correctly
//    func testFetchMainCategories_Success() {
//        // Mock network manager
//        let mockNetworkManager = MockNetworkManager(result: .success(Categories(code: 200, msg: "Success", data: DataClass(categories: []))))
//        formPresenter.networkManager = mockNetworkManager
//
//        formPresenter.fetchMainCategories()
//
//        // Verify that main categories are set and form view is updated
//        XCTAssertEqual(formPresenter.mainCategories.count, 0)
//        XCTAssertTrue(mockFormView.updateCategoryAndSubcategoryCalled)
//    }
//
//    // Test case 2: Check if fetching properties updates form view correctly
//    func testFetchProperties_Success() {
//        // Mock network manager
//        let mockNetworkManager = MockNetworkManager(result: .success(Properties(code: 200, msg: "Success", data: [])))
//        formPresenter.networkManager = mockNetworkManager
//
//        formPresenter.fetchProperties()
//
//        // Verify that properties are set and form view is updated
//        XCTAssertEqual(formPresenter.properties.count, 0)
//        XCTAssertTrue(mockFormView.updatePropertiesCalled)
//    }
//
//    // Test case 3: Check if fetching options child updates form view correctly
//    func testFetchOptionsChild_Success() {
//        // Mock network manager
//        let mockNetworkManager = MockNetworkManager(result: .success(Models(code: 200, msg: "Success", data: [])))
//        formPresenter.networkManager = mockNetworkManager
//
//        formPresenter.fetchOptionsChild()
//
//        // Verify that model options are set and form view is updated
//        XCTAssertEqual(formPresenter.modelOptions?.count, 0)
//        XCTAssertTrue(mockFormView.updateModelsCalled)
//    }
//
//    // Test case 4: Check handling of network error when fetching main categories
//    func testFetchMainCategories_NetworkError() {
//        // Mock network manager with a failure result
//        let mockNetworkManager = MockNetworkManager(result: .failure(.invalidURL))
//        formPresenter.networkManager = mockNetworkManager
//
//        formPresenter.fetchMainCategories()
//
//        // Verify that form view is not updated due to network error
//        XCTAssertFalse(mockFormView.updateCategoryAndSubcategoryCalled)
//    }
//
//    // Test case 5: Check handling of network error when fetching properties
//    func testFetchProperties_NetworkError() {
//        // Mock network manager with a failure result
//        let mockNetworkManager = MockNetworkManager(result: .failure(.requestFailed(NSError())))
//        formPresenter.networkManager = mockNetworkManager
//
//        formPresenter.fetchProperties()
//
//        // Verify that form view is not updated due to network error
//        XCTAssertFalse(mockFormView.updatePropertiesCalled)
//    }
//
//    // Test case 6: Check handling of network error when fetching options child
//    func testFetchOptionsChild_NetworkError() {
//        // Mock network manager with a failure result
//        let mockNetworkManager = MockNetworkManager(result: .failure(.decodingFailed))
//        formPresenter.networkManager = mockNetworkManager
//
//        formPresenter.fetchOptionsChild()
//
//        // Verify that form view is not updated due to network error
//        XCTAssertFalse(mockFormView.updateModelsCalled)
//    }
//}
