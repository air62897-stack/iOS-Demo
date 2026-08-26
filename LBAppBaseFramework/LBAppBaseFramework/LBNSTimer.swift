//
//  LBNSTimer.swift
//  LBAppBaseFramework
//
//  Created by ksnowlv on 2024/9/10.
//

import Foundation


@objc open class LBNSTimer: NSObject {
    private static let sharedQueue = DispatchQueue(label: "com.example.sharedQueue", attributes: .concurrent)
    private var timer: DispatchSourceTimer?
    private var isRunning: Bool = false
    
    @objc public func start() {
        guard !isRunning else {
            print("Timer is already running")
            return
        }
        
        isRunning = true
        
        let timer = DispatchSource.makeTimerSource(queue: LBNSTimer.sharedQueue)
        timer.schedule(wallDeadline: .now(), repeating: .seconds(1))
        
        
        timer.setEventHandler { [weak self] in
            self?.onTimer()
        }
        timer.resume()
        self.timer = timer
    }
    
    @objc public func stop() {
        guard isRunning else {
            print("Timer is not running")
            return
        }
        
        isRunning = false
        
        timer?.cancel()
        timer = nil
    }
    
    private func onTimer() {
        print("Timer fired")
        // 在这里添加你的定时任务代码
    }
}
