//
//  Timer.swift
//  BankManagerUIApp
//
//  Created by Swain Yun on 11/13/23.
//

import Foundation

protocol TimerProtocol {
    func fire(_ handler: @escaping (String) -> Void)
    func reset(_ handler: @escaping (String) -> Void)
    func pause()
}

final class BankTimer {
    private enum TimerStatus {
        case on, off
    }
    
    private var timer: Timer?
    private let timeInterval: TimeInterval
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss:SSS"
        return formatter
    }()
    private var timerStatus: TimerStatus = .off
    private var savedTimeStamp: TimeInterval = 0
    private var elapsedTime: TimeInterval = 0
    
    init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    private func representTimeLabel(_ handler: @escaping (String) -> Void) {
        let timeText = dateFormatter.string(from: Date(timeIntervalSinceReferenceDate: elapsedTime))
        handler(timeText)
    }
}

// MARK: Timer Protocol Implementation
extension BankTimer: TimerProtocol {
    func fire(_ handler: @escaping (String) -> Void) {
        guard timerStatus == .off else { return }
        
        timerStatus = .on
        let startTime = Date()
        
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] _ in
            let elapsedTime: TimeInterval = Date().timeIntervalSince(startTime)
            guard let self = self else { return }
            self.elapsedTime = elapsedTime + savedTimeStamp
            self.representTimeLabel(handler)
        })
        
        if let timer = timer {
            RunLoop.main.add(timer, forMode: .tracking)
        }
    }
    
    func reset(_ handler: @escaping (String) -> Void) {
        timer?.invalidate()
        timer = nil
        timerStatus = .off
        savedTimeStamp = 0
        
        representTimeLabel(handler)
    }
    
    func pause() {
        timer?.invalidate()
        timer = nil
        timerStatus = .off
        savedTimeStamp = elapsedTime
    }
}
