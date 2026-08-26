//
//  LBSpotACStore.swift
//  LBSpotStore
//
//  Created by ksnowlv on 2024/9/20.
//

import Foundation
import LBAppBaseFramework
import GRDB


class LBSpotACStore: LBGRDBStore {
    
    var cache = [LBSpotDBACItem]()
    
    
    override init() {
        super.init()
        self.createTable(LBSpotACStore.dbQueue)
    }
    
    
    func createTable(_ queue:DatabaseQueue?) {
        do {
            try queue?.write { db in
                // 创建表
                try db.create(table: LBSpotDBACItem.databaseTableName, ifNotExists: true) { table in
                    table.autoIncrementedPrimaryKey(LBSpotDBACItem.columnsID)
                    table.column(LBSpotDBACItem.columnsAC, .text).notNull().unique()
                    table.column(LBSpotDBACItem.columnsAS, .text).notNull().unique()
                    table.column(LBSpotDBACItem.columnsDES, .boolean)
                    table.column(LBSpotDBACItem.columnsDRS, .boolean)
                    table.column(LBSpotDBACItem.columnsHM, .boolean)
                    table.column(LBSpotDBACItem.columnsI, .text)
                    table.column(LBSpotDBACItem.columnsNE, .text)
                    table.column(LBSpotDBACItem.columnsNZ, .text)
                    table.column(LBSpotDBACItem.columnsP, .integer)
                    table.column(LBSpotDBACItem.columnsSDRS, .boolean)
                    table.column(LBSpotDBACItem.columnsSS, .boolean)
                }
                
                try db.create(index: "index_ac", on: LBSpotDBACItem.databaseTableName, columns: [LBSpotDBACItem.columnsAC],unique: true, ifNotExists: true)
            }
        } catch {
            print("Database setup failed: \(error)")
        }
    }
    
    func insertSpotDBACItemsWithTransaction(_ acItems:[LBSpotDBACItem]) {
        
        do {
            try LBGRDBStore.dbQueue?.inTransaction(.exclusive,{ [weak self] db in
                
                guard let strongSelf = self else { return  .rollback}
                
                do {
                    
                    for var item in acItems {
                        try item.insert(db, onConflict: .ignore)
                    }

                    // 如果所有插入操作都成功，返回 .commit 提交事务
                    return .commit
                } catch {
                    // 如果发生错误，返回.rollback并回滚事务
                    print("Error inserting events: \(error)")
                    return .rollback
                }
            })
            
        } catch {
            print("Failed to insert events:\(error)")
        }
    }
    
    
    func deleteSpotDBACItem(_ acItem: LBSpotDBACItem) {
      
        do {
            _ = try LBGRDBStore.dbQueue?.write { db in
                
                try LBSpotDBACItem.filter(Column(LBSpotDBACItem.columnsAC) == acItem.ac).deleteAll(db)
            }
        } catch {
            print("Database write failed: \(error)")
        }
    }
    
    
    func deleteSpotDBACItems(_ acItems:  [LBSpotDBACItem]) {
        do {
            try LBGRDBStore.dbQueue?.write { db in
                for acItem in acItems {
               
                    try LBSpotDBACItem.filter(LBSpotDBACItem.Columns.ac == acItem.ac).deleteAll(db)
                }
            }
        } catch {
            print("Database write failed: \(error)")
        }
    }
    
    
    func fetchSpotDBACItems(_ limitNumber: Int = 100) -> ([LBSpotDBACItem], Bool ){
        var items: [LBSpotDBACItem] = []
        do {
            let request = LBSpotDBACItem.all().limit(limitNumber)
            try LBGRDBStore.dbQueue?.read{ db in
                do {
                    items = try request.fetchAll(db)
                } catch {
                    print("Error fetching items: \(error)")
                }
            }
        } catch {
            print("Database read failed: \(error)")
        }
        
        return (items, items.count == limitNumber)
    }
}
