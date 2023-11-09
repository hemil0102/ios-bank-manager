//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Swain Yun on 10/31/23.
//

import Foundation

struct Customer {
    let id: Int
    let workType: WorkType
    
    init(id: Int, workType: WorkType) {
        self.id = id
        self.workType = workType
    }
}
