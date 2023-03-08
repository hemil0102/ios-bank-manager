//
//  BankTextCollection.swift
//  BankManagerConsoleApp
//
//  Created by 송선진 on 2023/02/27.
//

import Foundation

enum BankTextCollection {
    
    static var consoleMenu: String {
        let menus = Menu.allCases.map { menu in
            "\(menu.rawValue) : \(menu)\n"
        }.joined()
        return menus + "입력 : "
    }
    
    static func close(numberOfCustomer: UInt, customerTime: Double) -> String {
        let time = String(format:"%.2f", customerTime)
        return "업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(numberOfCustomer)명이며, 총 업무시간은 \(time)초 입니다.\n"
    }
    
    static func working(order: UInt, task: String ,inProgress: Bool) -> String {
        let resultString = (inProgress == true) ? "시작" : "완료"
        return "\(order)번 \(task)업무 \(resultString)\n"
    }
    
}
