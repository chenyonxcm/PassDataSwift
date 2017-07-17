//
//  NextViewController.swift
//  PassDataSwift
//
//  Created by chenyong on 17/7/14.
//  Copyright © 2017年 chenyong. All rights reserved.
//

import UIKit
// 制定协议
protocol NextViewControllerDelegate:NSObjectProtocol {
    func passData(value:NSString)
}

// 定义一个参数为string类型无返回值的闭包（类似于oc的block）
typealias passDataBlock = (String)->()

class NextViewController: UIViewController {

    var customField : UITextField!
    // weak定义代理属性
    weak var delegate : NextViewControllerDelegate?
    // 把闭包生命成属性
    var myBlock : passDataBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.green
        
        customField = UITextField(frame:CGRect(x:100,y:200,width:150,height:50))
        self.view.addSubview(customField)
        customField.becomeFirstResponder()
        customField.backgroundColor = UIColor.red

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1. 通知传值
//        let dic = NSMutableDictionary()
//        if (customField.text != nil) {
//            dic.setValue(customField.text, forKey: "value")
//            NotificationCenter.default.post(name: NotificationName, object: dic)
//        }
        
        // 2. 代理传值
        // 代理属性调用代理方法
//        delegate?.passData(value: customField.text! as NSString)
        
        // 闭包传值
        myBlock!(customField.text!)
        
        self.dismiss(animated: true, completion: nil)
    }
}
