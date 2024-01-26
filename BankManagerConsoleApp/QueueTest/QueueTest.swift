//
//  QueueTest.swift
//  QueueTest
//
//  Created by Roh on 1/23/24.
//

import XCTest
@testable import BankManagerConsoleApp

<<<<<<< Updated upstream:BankManagerConsoleApp/QueueTest/QueueTest.swift
final class QueueTest: XCTestCase {
    var sut: BankTellerQueue<Int>!
=======
final class BankTellerQueueTest: XCTestCase {
    var bankTellerQueue: BankTellerQueue<Int>!
>>>>>>> Stashed changes:BankManagerConsoleApp/QueueTest/BankTellerQueueTest.swift

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = BankTellerQueue<Int>()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_queue에enqueue호출후_1을_넣고_peek호출시_1을_반환하는지() {
        //given
        let result = 1
        sut.enqueue(item: result)
        //when
        let peekResult = sut.peek()
        //then
        XCTAssertEqual(peekResult, result)
    }
    
    func test_queue에enqueue호출후_1를_추가하면_dequeue호출시_1을_반환하는지() {
        //given
        let result = 1
        sut.enqueue(item: result)
        //when
        let dequeueResult = sut.dequeue()
        //then
        XCTAssertEqual(dequeueResult, result)
        XCTAssertEqual(sut.dequeue(), nil)
    }
    
    func test_queue가비어있고_dequeue호출시_nil을반환하는지() {
        //given
        //when
        guard sut.isEmpty() else {
            XCTFail()
            return
        }
        let dequeueResult = sut.dequeue()
        //then
        XCTAssertEqual(dequeueResult, nil)
    }
    
    func test_queue에enqueue호출후_123을_넣고_clear후_peek을_호출시_nil을_반환하는지() {
        //given
        for value in 1...3 {
            sut.enqueue(item: value)
        }
        //when
        sut.clear()
        let peekResult = sut.peek()
        //then
        XCTAssertEqual(peekResult, nil)
    }
    
    func test_queue에enqueue호출후_4를_넣고_clear호출시_isEmpty가true_count가_0을_반환하는지() {
        //given
        sut.enqueue(item: 4)
        //when
        sut.clear()
        let isEmptyResult = sut.isEmpty()
        let countResult = sut.count
        //then
        XCTAssertTrue(isEmptyResult)
        XCTAssertEqual(countResult, 0)
    }
    
    func test_queue에_isEmpty호출시_true를_반환하는지() {
        //given
        let result = true
        let anotherResult = false
        //when
        let isEmptyResult = sut.isEmpty()
        sut.enqueue(item: 1)
        //then
        XCTAssertEqual(isEmptyResult, result)
        XCTAssertEqual(sut.isEmpty(), anotherResult)
    }
    
    func test_queue에enqueue호출후_1부터15를넣고_10이_될때까지_dequeue시_10을_반환하는지() {
        //given
        var findNumber = 0
        let result = 10
        var dequeueResult: Int?
        for value in 1...15 {
            sut.enqueue(item: value)
        }
        //when
        while !(findNumber == 10) {
            findNumber += 1
            dequeueResult = sut.dequeue()
        }
        //then
        XCTAssertEqual(dequeueResult, result)
    }
    
    func test_queue애enqueue_1을넣고_2번_dequeue시_nil을_반환하는지() {
        //given
        var dequeueResult: Int?
        sut.enqueue(item: 1)
        //when
        for _ in 1...2 {
            dequeueResult = sut.dequeue()
        }
        //then
        XCTAssertEqual(dequeueResult, nil)
    }
}
