//
//  OperationQueue.swift
//  BankManagerConsoleApp
//
//  Created by Janine on 11/6/23.
//

import Foundation

extension OperationQueue {
    static func waitUntilAllOperationsAreFinished(_ queue: OperationQueue...) {
        queue.forEach { $0.waitUntilAllOperationsAreFinished() }
    }
    
    convenience init(name: String, maxConcurrentOperationCount: Int?) {
        self.init()
        self.name = name
        guard let max = maxConcurrentOperationCount else { return }
        self.maxConcurrentOperationCount = max
    }
}
