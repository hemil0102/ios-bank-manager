//
//  Queue.swift
//  BankManagerConsoleApp
//
//  Created by 김수경 on 2023/10/30.
//

import Foundation

struct Queue<T> {
    private var head: Node<T>? = nil
    private var tail: Node<T>? = nil
    
    var isEmpty: Bool {
        return head == nil && tail == nil
    }
    
    var peek: T? {
        return head?.data
    }
    
    mutating func enqueue(data: T) {
        let node: Node<T> = Node(with: data)
        if isEmpty {
            self.head = node
        }
        
        tail?.next = node
        tail = node
    }
    
    mutating func dequeue() -> T? {
        let data = self.peek
        self.head = head?.next
        
        if self.head == nil {
            tail = nil
        }
        return data
    }
    
    mutating func clear() {
        head = nil
        tail = nil
    }
    
    private final class Node<T> {
        var data: T
        var next: Node?
        
        init(with data: T, next: Node? = nil) {
            self.data = data
            self.next = next
        }
    }
}

