//
//  ViewController.swift
//  LBSpotStore
//
//  Created by ksnowlv on 2024/9/20.
//

import UIKit

class ViewController: UIViewController {
    let acStore = LBSpotACStore()
    let scStore = LBSpotSCStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        jsonToDB()
    }
    
    func jsonToDB() {
        // 获取 config.json 文件的路径
        guard let fileURL = Bundle.main.url(forResource:"spot_baseConfig",withExtension:"json") else {
            print("config.json 文件未找到")
            return
        }
        
        do {
            // 读取文件内容
            let data = try Data(contentsOf:fileURL)
            
            // 解析 JSON 数据
            if let json = try JSONSerialization.jsonObject(with:data,options:[]) as?[String:Any] {
                // 这里得到了解析后的 JSON 数据，可以根据需要进行处理
                
                guard let jsonData = json["data"] as?[String:Any] else {
                    return
                }
                
                let decoder = JSONDecoder()
                
                if let acData = jsonData["ac"] as? Array<[String:Any]> {
                    
                    var acList = [LBSpotDBACItem]()
                    
                    for item in acData {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: item, options: [])
                            let acItem = try decoder.decode(LBSpotDBACItem.self, from: jsonData)
                            acList.append(acItem)
                        } catch {
                            print("Error decoding ACItem: \(item)")
                            print("Error decoding ACItem: \(error)")
                        }
                    }
                    
                    acStore.insertSpotDBACItemsWithTransaction(acList)
                }
               
                if let scData = jsonData["sc"] as? Array<[String:Any]> {
                    
                    var scList = [LBSpotDBSCItem]()
                    
                    for item in scData {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: item, options: [])
                            let scItem = try decoder.decode(LBSpotDBSCItem.self, from: jsonData)
                            scList.append(scItem)
                        } catch {
                            print("Error decoding SCItem: \(item)")
                            print("Error decoding SCItem: \(error)")
                        }
                    }
                    
                    scStore.insertSpotDBSCItemsWithTransaction(scList)
                }
                
                
            } else {
                print("解析 config.json 文件失败")
            }
        } catch {
            print("加载 config.json 文件失败：\(error.localizedDescription)")
        }
    }
}

