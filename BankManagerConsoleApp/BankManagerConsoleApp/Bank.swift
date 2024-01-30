//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Jin-Mac on 1/30/24.
//

import Foundation

struct Bank {
    var bankWatingQueue = CustomerQueue<Customer>()
    var clerk: BankClerk
    
    init(clerk: BankClerk = BankClerk()) {
        self.clerk = clerk
    }
}
