//
//  ViewController.swift
//  LBAppBaseFrameworkTest
//
//  Created by ksnowlv on 2024/9/10.
//

import UIKit
import LBAppBaseFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let timer = LBNSTimer()
        timer.start()
        

        BClass.showInfomation("aaaaa")
        
        let a = AClass()
        a.testAClass("aaa")
    }
}

