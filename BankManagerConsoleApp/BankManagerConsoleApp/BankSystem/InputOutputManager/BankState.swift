//
//  BankState.swift
//  BankManagerConsoleApp
//
//  Created by DONGWOOK SEO on 2023/02/27.
//

import Foundation

enum BankState {
    
    case open
    case close(UInt, Double)
    case working(UInt, String, Bool)
    
}

extension BankState {
    
    var text: String {
        switch self {
        case .open:
            return BankTextCollection.consoleMenu
        case .close(let numberOfCustomer, let totalDuration):
            return BankTextCollection.close(numberOfCustomer: numberOfCustomer, customerTime: totalDuration)
        case .working(let order, let task, let result):
            return BankTextCollection.working(order: order, task: task , inProgress: result)
        }
    }
    
}
