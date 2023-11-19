//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Wonji Ha on 2023/11/07.
//

import Foundation

protocol BankDelegate: TellerWorkingStateNotifiable {
    func gatherCustomers(bank: Bank, from startCount: Int, to endCount: Int)
    func updateWaitingCustomersList(bank: Bank, customer: Customer)
    func updateWorkingCustomersList(bank: Bank, customer: Customer)
}

final class Bank {
    private let customerQueue = Queue<Customer>()
    private let dispatchGroup = DispatchGroup()
    private let tellers: [TellerProtocol]
    private var servicedCustomersCount = 0
    private var totalServicedTimes: TimeInterval = 0.0
    private weak var bankManager: BankDelegate?
    
    init(bankDelegate bankManager: BankDelegate) {
        self.tellers = [Teller(tellerCount: 2, bankManager: bankManager), Teller(tellerCount: 1, bankManager: bankManager)]
        self.bankManager = bankManager
    }
    
    func work(completion: @escaping (Bool) -> Void) {
        tellers.forEach { teller in
            DispatchQueue.global().async(group: dispatchGroup, qos: .background) { [self] in
                while customerQueue.isEmpty == false {
                    guard let customer = customerQueue.dequeue() else { return }
                    
                    matchUpService(with: customer, on: teller)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [self] in
            completion(customerQueue.isEmpty)
        }
    }
    
    func gatherCustomers(from: Int, to: Int) {
        for count in from...to {
            guard let randomWorkType = WorkType.allCases.randomElement() else { return }
            let customer = Customer(id: count, workType: randomWorkType)
            customerQueue.enqueue(customer)
            
            self.bankManager?.updateWaitingCustomersList(bank: self, customer: customer)
        }
    }
    
    func removeCustomers() {
        customerQueue.clear()
    }
}

// MARK: Private Methods
extension Bank {
    private func matchUpService(with customer: Customer, on teller: TellerProtocol) {
        teller.service(to: customer) { [self] in
            servicedCustomersCount += 1
            totalServicedTimes += customer.workType.timeCost
            
            DispatchQueue.main.async {
                self.bankManager?.updateWorkingCustomersList(bank: self, customer: customer)
            }
        }
    }
}
