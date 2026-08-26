//
//  LBSpotDBACItem.swift
//  LBSpotStore
//
//  Created by ksnowlv on 2024/9/20.
//

import Foundation
import GRDB

//{
//    "ac": "inno",
//    "bc": "wut",
//    "bca": "wut",
//    "bp": 2,
//    "hm": false,
//    "ietf": false,
//    "ig": false,
//    "mtq": "10",
//    "pids": [],
//    "pp": 5,
//    "qc": "usdt",
//    "qca": "usdt",
//    "qp": 4,
//    "s": "wut_usdt"
//},


struct LBSpotDBSCItem : Codable, FetchableRecord, TableRecord, MutablePersistableRecord{
    
    var id: Int64?
    var ac: String
    var bc: String
    var bca: String
    var bp: Int
    var hm: Bool
    var ietf: Bool
    var ig: Bool
    var mtq: String
    var pids:Int
    var pp: Int
    var qc: String
    var qca:String
    var qp: Int
    var s: String
    
    static let databaseTableName = "SpotDBSCItem"
    
    static let columnsID = "id"
    static let columnsAC = "ac"
    static let columnsBC = "bc"
    static let columnsBCA = "bca"
    static let columnsBP = "bp"
    static let columnsHM = "hm"
    static let columnsIETF = "ietf"
    static let columnsIG = "ig"
    static let columnsMTQ = "mtq"
    static let columnsPIDS = "pids"
    static let columnsPP = "pp"
    static let columnsQC = "qc"
    static let columnsQCA = "qca"
    static let columnsQP = "qp"
    static let columnsS = "s"
    
    enum CodingKeys: String, CodingKey {
        case id
        case ac
        case bc
        case bca
        case bp
        case hm
        case ietf
        case ig
        case mtq
        case pids
        case pp
        case qc
        case qca
        case qp
        case s
    }
    
    
    // 从数据库行数据初始化
    init(row: Row) {
        id = row[LBSpotDBSCItem.columnsID]
        ac = row[LBSpotDBSCItem.columnsAC]
        bc = row[LBSpotDBSCItem.columnsBC]
        bca = row[LBSpotDBSCItem.columnsBCA]
        bp = row[LBSpotDBSCItem.columnsBP]
        hm = row[LBSpotDBSCItem.columnsHM]
        ietf = row[LBSpotDBSCItem.columnsIETF]
        ig = row[LBSpotDBSCItem.columnsIG]
        mtq = row[LBSpotDBSCItem.columnsMTQ]
        pids = row[LBSpotDBSCItem.columnsPIDS]
        pp = row[LBSpotDBSCItem.columnsPP]
        qc = row[LBSpotDBSCItem.columnsQC]
        qca = row[LBSpotDBSCItem.columnsQCA]
        qp = row[LBSpotDBSCItem.columnsQP]
        s = row[LBSpotDBSCItem.columnsS]
    }
    

    // 将模型数据保存到数据库行
    mutating func encode(to container: inout PersistenceContainer) {
        container[LBSpotDBSCItem.columnsID] = id
        container[LBSpotDBSCItem.columnsAC] = ac
        container[LBSpotDBSCItem.columnsBC] = bc
        container[LBSpotDBSCItem.columnsBCA] = bca
        container[LBSpotDBSCItem.columnsBP] = bp
        container[LBSpotDBSCItem.columnsHM] = hm
        container[LBSpotDBSCItem.columnsIETF] = ietf
        container[LBSpotDBSCItem.columnsIG] = ig
        container[LBSpotDBSCItem.columnsMTQ] = mtq
        container[LBSpotDBSCItem.columnsPIDS] = pids
        container[LBSpotDBSCItem.columnsPP] = pp
        container[LBSpotDBSCItem.columnsQC] = qc
        container[LBSpotDBSCItem.columnsQCA] = qca
        container[LBSpotDBSCItem.columnsQP] = qp
        container[LBSpotDBSCItem.columnsS] = s
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int64.self, forKey: .id)
        ac = try container.decode(String.self, forKey: .ac)
        bc = try container.decode(String.self, forKey: .bc)
        bca = try container.decode(String.self, forKey: .bca)
        bp = try container.decode(Int.self, forKey: .bp)
        hm = try container.decode(Bool.self, forKey: .hm)
        ietf = try container.decode(Bool.self, forKey: .ietf)
        ig = try container.decode(Bool.self, forKey: .ig)
        mtq = try container.decode(String.self, forKey: .mtq)
        let pidArray =  try container.decode([Int].self, forKey: .pids)
        
        if pidArray.isEmpty {
            pids = 0
        } else {
            pids = pidArray[0]
        }
        
        pp = try container.decode(Int.self, forKey: .pp)
        qc = try container.decode(String.self, forKey: .qc)
        qca = try container.decode(String.self, forKey: .qca)
        qp = try container.decode(Int.self, forKey: .qp)
        s = try container.decode(String.self, forKey: .s)
    }
}

extension LBSpotDBSCItem {
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let ac = Column(CodingKeys.ac)
        static let bc = Column(CodingKeys.bc)
        static let bca = Column(CodingKeys.bca)
        static let bp = Column(CodingKeys.bp)
        static let hm = Column(CodingKeys.hm)
        static let ietf = Column(CodingKeys.ietf)
        static let ig = Column(CodingKeys.ig)
        static let mtq = Column(CodingKeys.mtq)
        static let pids = Column(CodingKeys.pids)
        static let pp = Column(CodingKeys.pp)
        static let qc = Column(CodingKeys.qc)
        static let qca = Column(CodingKeys.qca)
        static let qp = Column(CodingKeys.qp)
        static let s = Column(CodingKeys.s)
    }
}

