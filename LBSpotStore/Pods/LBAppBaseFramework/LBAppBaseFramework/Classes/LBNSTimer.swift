//
//  LBNSTimer.swift
//  LBAppBaseFramework
//
//  Created by ksnowlv on 2024/9/10.
//

import Foundation


@objc public class LBNSTimer: NSObject {
    public var userInfo: Any?
    private static let sharedQueue = DispatchQueue(label: "com.example.sharedQueue", attributes: .concurrent)
    private var timer: DispatchSourceTimer?
    private var isRunning: Bool = false
    private var target: AnyObject?
    private var selector: Selector?
   
    
    @objc public init(timeInterval ti: TimeInterval, repeats: Bool, block: @escaping @Sendable (LBNSTimer) -> Void) {
        super.init()
        
        isRunning = true
        
        let timer = DispatchSource.makeTimerSource(queue: LBNSTimer.sharedQueue)
        timer.schedule(wallDeadline: .now(), repeating: .seconds(Int(ti)))
        
        timer.setEventHandler { [weak self] in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                block(strongSelf)
            }
        }
        timer.resume()
        self.timer = timer
    }
    
    @objc public init(timeInterval ti: TimeInterval, target aTarget: AnyObject, selector aSelector: Selector, userInfo: Any?, repeats yesOrNo: Bool) {
        super.init()
        self.target = aTarget
        self.selector = aSelector
        self.userInfo = userInfo
        
        isRunning = true
        
        let timer = DispatchSource.makeTimerSource(queue: LBNSTimer.sharedQueue)
        timer.schedule(wallDeadline: .now(), repeating: .seconds(Int(ti)))
        
        timer.setEventHandler { [weak self] in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                if let target = strongSelf.target,
                   let selector = strongSelf.selector,
                   target.responds(to: selector) {
                    let _ =  target.perform(strongSelf.selector, with: strongSelf.userInfo)
                } else {
                    print("Target object does not respond to the selector")
                }
                
            }
        }
        timer.resume()
        self.timer = timer
        
    }
    
    @objc public class func scheduledTimer(timeInterval ti: TimeInterval, repeats: Bool, block: @escaping @Sendable (LBNSTimer) -> Void) -> LBNSTimer {
        return LBNSTimer(timeInterval: ti, repeats: repeats, block: block)
    }
    
    
    @objc public class func scheduledTimer(timeInterval ti: TimeInterval, target aTarget: AnyObject, selector aSelector: Selector, userInfo: Any?, repeats yesOrNo: Bool) -> LBNSTimer {
        return LBNSTimer(timeInterval: ti, target: aTarget, selector: aSelector, userInfo: userInfo, repeats: yesOrNo)
    }
    
    @objc public func cancel() {
        guard isRunning else {
            return
        }
        
        isRunning = false
        
        timer?.cancel()
        timer = nil
        self.target = nil
        self.selector = nil
        self.userInfo = nil
    }
}
