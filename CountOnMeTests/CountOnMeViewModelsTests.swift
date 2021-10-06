//
//  CountOnMeViewModelsTests.swift
//  CountOnMeTests
//
//  Created by Nora Lilla Matyassi on 04/10/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeViewModelsTests: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    var viewModel = CalculatorViewModel()
    let observer = CalculatorViewModelObserver()

    func testCanAddOperator() {
        viewModel.delegate = observer
        viewModel.setCalculusElements(elements: ["1", "+", "1"])

        XCTAssertTrue(viewModel.canAddOperator)

    }

    func testExecuteCalculusWhenCalculusHasCompleted() {
        viewModel.delegate = observer

        viewModel.setCalculusElements(elements: ["1", "+", "1"])
        viewModel.executeCalculus()

        XCTAssertTrue(observer.calculusHasCompleted)
    }

    func testExecuteCalculusWhenCalculusHasFailed() {
        viewModel.delegate = observer
        viewModel.setCalculusElements(elements: ["1", "+"])
        viewModel.executeCalculus()

        XCTAssertTrue(observer.calculusHasFailed)
    }

    func testShouldReturnNotEnoughElements(errorMessage: String) {
        viewModel.delegate = observer
        viewModel.setCalculusElements(elements: ["1", "+"])

        XCTAssertEqual(observer.calculusHasFailed, true, "not enough elements")
    }

    func testShouldReturnIvalidExpression(errorMessage: String) {
        viewModel.delegate = observer
        viewModel.setCalculusElements(elements: ["1", "+", "-"])
        viewModel.executeCalculus()
        let errorMessage = "invalide expression"
        XCTAssertEqual(errorMessage, "invalide expression")
    //    XCTAssertEqual(observer.calculusHasFailed, true, "invalide expression")
    }

    func testShouldReturnDivisionByZero(errorMessage: String) {
        viewModel.delegate = observer
        viewModel.setCalculusElements(elements: ["1", "≠", "0"])
        viewModel.executeCalculus()
        XCTAssertEqual(observer.calculusHasFailed, true, "you can't divide by zero")
    }

    func testIfClearAllIsClearsTheListOfElements() {
        viewModel.delegate = observer

        viewModel.setCalculusElements(elements: ["1", "+", "1"])
        viewModel.clearAll()
    }

}

class CalculatorViewModelObserver: CalculatorViewModelDelegate {
    var calculusHasCompleted = false
    var calculusHasFailed = false

    func calculusHasCompleted(result: String) {
        calculusHasCompleted = true
    }

    func calculusFailed(errorMessage: String) {
        calculusHasFailed = true

    }
}
