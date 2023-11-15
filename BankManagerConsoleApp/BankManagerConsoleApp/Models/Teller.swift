//
//  Teller.swift
//  BankManagerConsoleApp
//
//  Created by Wonji Ha on 2023/11/07.
//

import Foundation

protocol TellerProtocol {
    func service(to customer: Customer, completion: @escaping () -> Void)
}

struct Teller: TellerProtocol {
    private let semaphore: DispatchSemaphore
    
    init(tellerCount: Int) {
        self.semaphore = DispatchSemaphore(value: tellerCount)
    }
    
    func service(to customer: Customer, completion: @escaping () -> Void) {
        semaphore.wait()
        Thread.sleep(forTimeInterval: customer.workType.timeCost)
        semaphore.signal()
        print("\(customer.id) - \(customer.workType) 처리")
        completion()
    }
}
