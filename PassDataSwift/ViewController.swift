//
//  ViewController.swift
//  PassDataSwift
//
//  Created by chenyong on 17/7/14.
//  Copyright © 2017年 chenyong. All rights reserved.
//

/**
 * 用swift写的一个反向传值的小需求，ViewController上又个label，NextViewController上有个textfield，在NextViewController上输入字符返回ViewController，在label显示输入的字符
 *用三种方法实现(通知，代理，闭包)
 */

import UIKit

let NotificationName = NSNotification.Name(rawValue:"Notification")

class ViewController: UIViewController,NextViewControllerDelegate {
    var customLabel : UILabel!
    // 不要忘记注销通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        customLabel = UILabel(frame:CGRect(x:0,y:0,width:200,height:50))
        customLabel.center = self.view.center
        customLabel.backgroundColor = UIColor.purple
        self.view.addSubview(customLabel)
        // 注册一个通知
        NotificationCenter.default.addObserver(self, selector:#selector(passData(notification:)) , name: NotificationName, object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = NextViewController()
        // 设置代理为self
        vc.delegate = self
        
        // 避免循环引用
        weak var weakSelf = self
        vc.myBlock = { (value)->() in
            weakSelf?.customLabel.text = value
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func passData(notification:NSNotification) {
        var dic : NSDictionary?
        // 此处需要说明一下，在oc中传值以一个字典的形式接收用notification.userInfo,但在swift中接受用notification.object，有所区别，需要注意下
        dic = notification.object as! NSDictionary?
        if dic != nil  {
            customLabel.text = dic?.object(forKey: "value") as? String
        }
    }
    
    // 调用代理方法
    func passData(value: NSString) {
        customLabel.text = value as String
    }
}

