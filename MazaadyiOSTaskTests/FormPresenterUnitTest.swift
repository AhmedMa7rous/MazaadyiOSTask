//
//  FormPresenterUnitTest.swift
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
        let mockCategories = Categories(code: 200, msg: "Success", data: DataClass(categories: [Category(id: 1, name: "Category1", slug: "category1", children:
                                                                                               [Category(id: 13, name: "cars", slug: "cars", children: nil),
                                                                                                Category(id: 16, name: "bicycles", slug: "bicycles", children: nil),
                                                                                                Category(id: 10, name: "Motors", slug: "Motors", children: nil)] )]))
        mockNetworkManager.result = .success(mockCategories)
        
        // When
        presenter.fetchMainCategories()
        
        // Then
        XCTAssertEqual(presenter.mainCategories.count, 1)
        XCTAssertEqual(presenter.mainCategories[0].children?[1].id, 16)
        XCTAssertEqual(presenter.mainCategories[0].children?[2].name, "Motors")
    }

    func testFetchMainCategoriesFailure() {
        // Given
        mockNetworkManager.result = .failure(.invalidURL)
        
        // When
        presenter.fetchMainCategories()
        
        // Then
        XCTAssertEqual(presenter.networkError, "Invalid")
    }

    // The remainning functions "fetchProperties, fetchOptionsChild, and getAllSelectedData" will test in a semilar way
}
