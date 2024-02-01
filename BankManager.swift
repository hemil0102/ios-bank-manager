//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct BankManager {
    private var totalCustomers: Int = 0
    private var totalTime: Double = 0
    
    private let banker: Banker = Banker()
    private let queue: Queue<Customer> = Queue(linkedList: LinkedList())
    
    mutating func main() {
        var isExit: Bool = false
        
        while !isExit {
            print("""
            1 : 은행 개점
            2 : 종료
            입력 :
            """, terminator: " ")
            
            guard let selectedMenu = readLine() else {
                return
            }
            
            switch selectedMenu {
            case "1":
                startBankingProcess { customer, time in
                    print("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(customer)명이며, 총 업무시간은 \(String(format: "%.2f", time))초입니다.")
                }
            case "2":
                isExit = true
            default:
                print("잘못된 입력입니다. 다시 입력해 주세요.")
                continue
            }
        }
    }
    
    mutating private func startBankingProcess(completionHandler: (_ customer: Int, _ time: Double) -> Void) {
        setupInitialInformation()
        
        while !queue.isEmpty() {
            guard let node = queue.dequeue() else {
                return
            }
            let customer = node.value
            DispatchQueue.global().sync {
                totalTime += banker.provideService(to: customer)
            }
        }
        
        completionHandler(totalCustomers, totalTime)
    }
    
    mutating private func setupInitialInformation() {
        totalCustomers = .random(in: 10...30)
        totalTime = 0
        
        for i in 1...totalCustomers {
            queue.enqueue(node: Node(value: Customer(requiredTime: 0.7, waitingNumber: i)))
        }
    }
}
