//
//  LBSpotDBACItem.swift
//  LBSpotStore
//
//  Created by ksnowlv on 2024/9/20.
//

import Foundation
import GRDB


//{
//    "ac": "ksm",
//    "as": "ksm",
//    "des": true,
//    "drs": true,
//    "hm": false,
//    "i": "/exchangeBm-upload/img/svg/SVG_16116534a.png",
//    "ne": "Kusama",
//    "nz": "Kusama",
//    "p": 8,
//    "sdrs": true,
//    "ss": true
//},

struct LBSpotDBACItem : Codable, FetchableRecord, TableRecord, MutablePersistableRecord{
    
    var id: Int64?
    var ac: String
    var asInfo: String
    var des: Bool
    var drs: Bool
    var hm: Bool
    var i: String?
    var ne: String
    var nz: String
    var p: Int
    var sdrs: Bool
    var ss: Bool
    
    static let databaseTableName = "SpotDBACItem"
    
    static let columnsID = "id"
    static let columnsAC = "ac"
    static let columnsAS = "as"
    static let columnsDES = "des"
    static let columnsDRS = "drs"
    static let columnsHM = "hm"
    static let columnsI = "i"
    static let columnsNE = "ne"
    static let columnsNZ = "nz"
    static let columnsP = "p"
    static let columnsSDRS = "sdrs"
    static let columnsSS = "ss"
    
    enum CodingKeys: String, CodingKey {
        case id
        case ac
        case asInfo = "as"
        case des
        case drs
        case hm
        case i
        case ne
        case nz
        case p
        case sdrs
        case ss
    }
    
    
    // 从数据库行数据初始化
    init(row: Row) {
        id = row[LBSpotDBACItem.columnsID]
        ac = row[LBSpotDBACItem.columnsAC]
        asInfo = row[LBSpotDBACItem.columnsAS]
        des = row[LBSpotDBACItem.columnsDES]
        drs = row[LBSpotDBACItem.columnsDRS]
        hm = row[LBSpotDBACItem.columnsHM]
        i = row[LBSpotDBACItem.columnsI]
        ne = row[LBSpotDBACItem.columnsNE]
        nz = row[LBSpotDBACItem.columnsNZ]
        p = row[LBSpotDBACItem.columnsP]
        sdrs = row[LBSpotDBACItem.columnsSDRS]
        ss = row[LBSpotDBACItem.columnsSS]
    }
    
    // 将模型数据保存到数据库行
    mutating func encode(to container: inout PersistenceContainer) {
        container[LBSpotDBACItem.columnsID] = id
        container[LBSpotDBACItem.columnsAC] = ac
        container[LBSpotDBACItem.columnsAS] = asInfo
        container[LBSpotDBACItem.columnsDES] = des
        container[LBSpotDBACItem.columnsDRS] = drs
        container[LBSpotDBACItem.columnsHM] = hm
        container[LBSpotDBACItem.columnsI] = i
        container[LBSpotDBACItem.columnsNE] = ne
        container[LBSpotDBACItem.columnsNZ] = nz
        container[LBSpotDBACItem.columnsP] = p
        container[LBSpotDBACItem.columnsSDRS] = sdrs
        container[LBSpotDBACItem.columnsSS] = ss
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int64.self, forKey: .id)
        ac = try container.decode(String.self, forKey: .ac)
        asInfo = try container.decode(String.self, forKey: .asInfo)
        des = try container.decode(Bool.self, forKey: .des)
        drs = try container.decode(Bool.self, forKey: .drs)
        hm = try container.decode(Bool.self, forKey: .hm)
        i = try container.decodeIfPresent(String.self, forKey: .i) // 处理可选字段
        ne = try container.decode(String.self, forKey: .ne)
        nz = try container.decode(String.self, forKey: .nz)
        p = try container.decode(Int.self, forKey: .p)
        sdrs = try container.decode(Bool.self, forKey: .sdrs)
        ss = try container.decode(Bool.self, forKey: .ss)
    }
    
    
}

// 扩展 LBSpotDBItem，定义数据库列
extension LBSpotDBACItem {
    enum Columns {
        static let id = Column(CodingKeys.id)
        static let ac = Column(CodingKeys.ac)
        static let asInfo = Column(CodingKeys.asInfo)
        static let des = Column(CodingKeys.des)
        static let drs = Column(CodingKeys.drs)
        static let hm = Column(CodingKeys.hm)
        static let i = Column(CodingKeys.i)
        static let ne = Column(CodingKeys.ne)
        static let nz = Column(CodingKeys.nz)
        static let p = Column(CodingKeys.p)
        static let sdrs = Column(CodingKeys.sdrs)
        static let ss = Column(CodingKeys.ss)
    }
}

