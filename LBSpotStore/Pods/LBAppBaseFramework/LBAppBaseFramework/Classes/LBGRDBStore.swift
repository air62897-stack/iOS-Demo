//
//  LBGRDBStore.swift
//  LBAppBaseFramework
//
//  Created by ksnowlv on 2024/9/18.
//

import Foundation
import GRDB


open class LBGRDBStore {
    
    private static let dbFileName = "LBankDbStore.sqlite"
    
    private static var filePath: String = {
        let dbFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(LBGRDBStore.dbFileName).path
#if DEBUG
        print("db filePath:\(String(describing: dbFilePath))")
#endif
        return dbFilePath ?? ""
    }()
    
    
    public static var dbQueue:DatabaseQueue? = {
        do {
            var configuration = Configuration()
            
#if DEBUG
            configuration.label = "GRDB" // 设置数据库标签，用于日志和调试
            // Enable verbose debugging in DEBUG builds only
            configuration.publicStatementArguments = true
            configuration.prepareDatabase { db in
                db.trace(options: .profile) { event in
                    
                    print(event)
                    if  case let .profile(statement, duration) = event, duration > 0.2 {
                        print("Slow query: \(statement.sql)")
                    }
                }
            }
#endif
            let queue = try DatabaseQueue(path: filePath, configuration: configuration)
            return queue
        } catch {
            print("Failed to open database: \(error)")
        }
        
        return nil
    }()
    
    public init() {
        
    }
    
}
