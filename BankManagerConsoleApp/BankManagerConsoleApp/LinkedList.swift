//
//  LinkedList.swift
//  BankManagerConsoleApp
//
//  Created by EUNJU on 2024/01/22.
//

import Foundation

final class Node<T> {
    var data: T
    var next: Node?
    
    init(_ data: T, _ next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

struct LinkedList<T> {
    
    var head: Node<T>?
    
    var first: T? {
        return head?.data
    }
    
    var isEmpty: Bool  {
        return head == nil ? true : false
    }
    
    init(head: Node<T>? = nil) {
        self.head = head
    }
}

// MARK: - Methods
extension LinkedList {
    
    /// Add    
    mutating func append(_ data: T) {
        let newNode = Node(data)
        
        if head == nil {
            head = newNode
            return
        }
        
        var node = head
        
        while(node?.next != nil) {
            node = node?.next
        }
        node?.next = newNode
    }

    /// Remove
    mutating func removeFirst() -> T? {
        let currentHead = head
        head = head?.next
        return currentHead?.data
    }
            
    mutating func removeAll() {
        head = nil
    }
}
