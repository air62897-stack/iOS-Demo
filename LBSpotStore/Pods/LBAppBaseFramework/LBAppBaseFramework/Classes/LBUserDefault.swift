//
//  LBUserDefault.swift
//  LBAppBaseFramework
//
//  Created by ksnowlv on 2024/9/13.
//

import UIKit

/// LBUserDefault replace UserDefault
@objc public class LBUserDefault: NSObject {
    private static  let queueNmae = "com.lbank.userdefaultconcurrentqueue"
    private static var userDefaultQueue: DispatchQueue = DispatchQueue(label: LBUserDefault.queueNmae, attributes: .concurrent)
    
    /// -setInteger:forKey: is equivalent to -setObject:forKey: except that the value is converted from an NSInteger to an NSNumber.
    public class func set(_ value: Int, forKey defaultName: String) {
        
        UserDefaults.standard.set(value, forKey: defaultName)
        LBUserDefault.userDefaultQueue.async {
            UserDefaults.standard.synchronize()
        }
    }
    
    
    /// -setFloat:forKey: is equivalent to -setObject:forKey: except that the value is converted from a float to an NSNumber.
    public class func set(_ value: Float, forKey defaultName: String) {
        
        UserDefaults.standard.set(value, forKey: defaultName)
        LBUserDefault.userDefaultQueue.async {
            UserDefaults.standard.synchronize()
        }
    }
    
    
    /// -setDouble:forKey: is equivalent to -setObject:forKey: except that the value is converted from a double to an NSNumber.
    public class func set(_ value: Double, forKey defaultName: String) {
        
        UserDefaults.standard.set(value, forKey: defaultName)
        LBUserDefault.userDefaultQueue.async {
            UserDefaults.standard.synchronize()
        }
    }
    
    
    /// -setBool:forKey: is equivalent to -setObject:forKey: except that the value is converted from a BOOL to an NSNumber.
    public class func set(_ value: Bool, forKey defaultName: String) {
        
        UserDefaults.standard.set(value, forKey: defaultName)
        LBUserDefault.userDefaultQueue.async {
            UserDefaults.standard.synchronize()
        }
    }
    
    public class func set(_ value: Any?, forKey defaultName: String) {
        
        UserDefaults.standard.set(value, forKey: defaultName)
        LBUserDefault.userDefaultQueue.async {
            UserDefaults.standard.synchronize()
        }
    }
    
    
    /// set Int
    /// - Parameters:
    ///   - value: Int
    ///   - defaultName: key
    @objc public class func setInteger(_ value: Int, forKey defaultName: String) {
        
        LBUserDefault.set(value, forKey: defaultName)
    }
    
    /// set Float
    /// - Parameters:
    ///   - value: Float
    ///   - defaultName: key
    @objc public class func setFloat(_ value: Float, forKey defaultName: String) {
        
        LBUserDefault.set(value, forKey: defaultName)
    }
    
    /// set Double
    /// - Parameters:
    ///   - value: Double
    ///   - defaultName: key
    @objc public class func setDouble(_ value: Double, forKey defaultName: String) {
        
        LBUserDefault.set(value, forKey: defaultName)
    }
    
    /// set Bool
    /// - Parameters:
    ///   - value: Bool
    ///   - defaultName: key
    @objc public class func setBool(_ value: Bool, forKey defaultName: String) {
        
        LBUserDefault.set(value, forKey: defaultName)
    }
    
    /// set Any
    /// - Parameters:
    ///   - value: Any
    ///   - defaultName: key
    @objc public class func setObject(_ value: Any?, forKey defaultName: String) {
        
        LBUserDefault.set(value, forKey: defaultName)
    }
    
    
    /// asynchronize data
    @objc public class func synchronize()  {
        LBUserDefault.userDefaultQueue.async {
            UserDefaults.standard.synchronize()
        }
    }
    
    /// remove object for key
    /// - Parameter defaultName:key
    @objc public class func removeObject(forKey defaultName: String) {
        UserDefaults.standard.removeObject(forKey: defaultName)
        LBUserDefault.userDefaultQueue.async {
            UserDefaults.standard.synchronize()
        }
    }
}
