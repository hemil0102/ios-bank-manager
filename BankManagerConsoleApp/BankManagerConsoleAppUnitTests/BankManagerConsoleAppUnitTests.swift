//
//  BankManagerConsoleAppUnitTests.swift
//  BankManagerConsoleAppUnitTests
//
//  Created by 장우석 on 1/24/24.
//

import XCTest
@testable import BankManagerConsoleApp

final class BankManagerConsoleAppUnitTests: XCTestCase {

    var sut: LinkedListQueue<String>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = LinkedListQueue()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_큐에_세개의_요소를_차례로_인큐하면_차례대로_디큐된다() {
        // given
        let firstElement: String = "1"
        let secondElement: String = "2"
        let thirdlement: String = "3"
        let expectation: Array<String> = ["1", "2", "3"]
        // when
        sut.enqueue(element: firstElement)
        sut.enqueue(element: secondElement)
        sut.enqueue(element: thirdlement)
        var enqueueResult: Array<String> = []
        enqueueResult.append(sut.dequeue()!)
        enqueueResult.append(sut.dequeue()!)
        enqueueResult.append(sut.dequeue()!)
        // then
        XCTAssertEqual(expectation, enqueueResult)
    }
    
    func test_큐에_아무것도_인큐하지_않으면_큐는_비어있다() {
        // given
        let expectation: Bool = true
        // when
        let result: Bool = sut.isEmpty
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_큐에_두개의_요소를_인큐했다가_clear_하면_큐가_비어있다() {
        // given
        let firstElement: String = "1"
        let secondElement: String = "2"
        let expectation: Bool = true
        // when
        sut.enqueue(element: firstElement)
        sut.enqueue(element: secondElement)
        sut.clear()
        let result: Bool = sut.isEmpty
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_큐에_두개의_요소를_인큐했다가_peek을_하면_천번째로_인큐한_요소가_나온다() {
        // given
        let firstElement: String = "1"
        let secondElement: String = "2"
        let expectation: String = "1"
        // when
        sut.enqueue(element: firstElement)
        sut.enqueue(element: secondElement)
        let result: String = sut.peek()!
        // then
        XCTAssertEqual(expectation, result)
    }
}
