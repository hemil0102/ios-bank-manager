//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 박찬호 on 1/30/24.
//

import Foundation

final class Bank<Q: QueueProtocol> where Q.Element == Customer {
    private var customerQueue: Q
    private let consoleMessage: ConsoleMessage
    private var totalCustomers: Int = 0
    private let depositSemaphore = DispatchSemaphore(value: 2)
    private let loanSemaphore = DispatchSemaphore(value: 1)
    private var totalTime : Double = 0
    
    init(customerQueue: Q, consoleMessage: ConsoleMessage) {
        self.customerQueue = customerQueue
        self.consoleMessage = consoleMessage
    }
    
    /// 고객 업무 시작
    func open(completion: @escaping () -> Void) {
        let numberOfCustomers = Int.random(in: 10...30)
        for number in 1...numberOfCustomers {
            let task = Bool.random() ? TaskType.deposit : TaskType.loan
            customerQueue.enqueue(Customer(waitingNumber: number, task: task))
        }
        totalCustomers = numberOfCustomers
        
        processCustomer {
            self.closed(totalTime: self.totalTime, completion: completion)
        }
    }
    
    /// 고객 업무 완료
    func processCustomer(completion: @escaping () -> Void) {
        let queue = DispatchQueue.global()
        let group = DispatchGroup()
        let startTime = DispatchTime.now()
        
        for _ in 1...totalCustomers {
            guard let customer = customerQueue.dequeue() else { continue }
            
            switch customer.task {
            case .deposit:
                depositSemaphore.wait()
                queue.async(group: group) {
                    self.handleCustomer(customer)
                    self.depositSemaphore.signal()
                }
            case .loan:
                loanSemaphore.wait()
                queue.async (group: group){
                    self.handleCustomer(customer)
                    self.loanSemaphore.signal()
                }
            }
        }
        
        group.wait()
        let endTime = DispatchTime.now()
        totalTime = Double(endTime.uptimeNanoseconds - startTime.uptimeNanoseconds) / 1_000_000_000
        completion()
        
    }
    
    func handleCustomer(_ customer: Customer) {
        switch customer.task {
        case .deposit:
            consoleMessage.taskStartMessage(customerNumber: customer.waitingNumber,
                                            task: customer.task.description)
            Thread.sleep(forTimeInterval: 0.7)
            consoleMessage.teskEndMessage(customerNumber: customer.waitingNumber,
                                          task: customer.task.description)
        case .loan:
            consoleMessage.taskStartMessage(customerNumber: customer.waitingNumber,
                                            task: customer.task.description)
            Thread.sleep(forTimeInterval: 1.1)
            consoleMessage.teskEndMessage(customerNumber: customer.waitingNumber,
                                          task: customer.task.description)
        }
    }
    
    /// 업무가 마감됨
    func closed(totalTime: Double, completion: @escaping () -> Void) {
//        consoleMessage.bankClosingMessage(totalCustomers: totalCustomers, time: totalTime)
        consoleMessage.bankClosingMessage(totalCustomers: totalCustomers, time: totalTime )
        completion()
    }
}
