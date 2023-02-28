//
//  WaitingQueue.swift
//  BankManagerConsoleApp
//
//  Created by 송선진 on 2023/02/21.
//

import Foundation

final class WaitingQueue<T> {
    
    private let queue: LinkedList = LinkedList<T>()
    
    func enqueue(_ newData: T) {
        queue.append(newData)
    }
    
    @discardableResult
    func dequeue() -> T? {
        return queue.removeFirst()
    }
    
    func clear() {
        queue.removeAll()
    }
    
    func peek() -> T? {
        return queue.showFirst()
    }
    
    func isEmpty() -> Bool {
        return queue.isEmpty
    }
    
}
