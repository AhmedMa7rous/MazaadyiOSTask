//
//  FormViewControllerTests.swift
//  MazaadyiOSTaskTests
//
//  Created by Ahmed Mahrous on 14/01/2024.
//

import XCTest
@testable import MazaadyiOSTask

class FormViewControllerTests: XCTestCase {

    var viewController: FormViewController!

    override func setUp() {
        super.setUp()
        let nib = UINib(nibName: "FormViewController", bundle: nil)
        viewController = nib.instantiate(withOwner: nil, options: nil).first as? FormViewController
        viewController.loadViewIfNeeded()
    }

    func testOutletsShouldBeConnected() {
        XCTAssertNotNil(viewController.categoriesDropDown)
        XCTAssertNotNil(viewController.subCategoryDropDown)
        XCTAssertNotNil(viewController.processTypeDropDown)
        XCTAssertNotNil(viewController.brandDropDown)
        XCTAssertNotNil(viewController.modelDropDown)
        XCTAssertNotNil(viewController.typeDropDown)
        XCTAssertNotNil(viewController.transmissionDropDown)
        XCTAssertNotNil(viewController.submitButton)
        XCTAssertNotNil(viewController.formStackView)
        XCTAssertNotNil(viewController.DropDowns)
    }

    func testSubmitButtonTapped() {
        // Given
        viewController.specifyTextField.text = "TestSpecification"

        // When
        viewController.submitButton.sendActions(for: .touchUpInside)

        // Then
        XCTAssertEqual(viewController.presenter.allSelectedData["Process type"], "TestSpecification")
    }

}
