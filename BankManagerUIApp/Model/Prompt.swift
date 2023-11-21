//
//  Prompt.swift
//  BankManagerConsoleApp
//
//  Created by 김진웅 on 2023/11/01.
//

import Foundation

enum Prompt: CustomStringConvertible {
    case menu
    case wrongInput
    case taskStart(with: Client)
    case taskComplete(with: Client)
    case close(numberOfClient: Int, totalTaskTime: Double)
    
    var description: String {
        switch self {
        case .menu:
            return  """
                    1 : 은행개점
                    2 : 종료
                    입력 : 
                    """
        case .wrongInput:
            return "잘못된 입력입니다. 다시 입력해 주세요!!"
        case .taskStart(let client):
            return "\(client.id)번 고객 \(client.taskType)업무 시작"
        case .taskComplete(let client):
            return "\(client.id)번 고객 \(client.taskType)업무 완료"
        case .close(let numberOfClient, let totalTaskTime):
            let time = String(format: "%.2f", totalTaskTime)
            return "업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(numberOfClient)명이며, 총 업무시간은 \(time)초입니다."
        }
    }
}
