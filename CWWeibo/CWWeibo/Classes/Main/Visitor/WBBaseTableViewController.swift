//
//  WBBaseTableViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBBaseTableViewController: UITableViewController {
    // MARK:- 懒加载
    lazy var visitorView : WBVisitorView = WBVisitorView.visitorView()
    
    var isLogin : Bool = false
    
    
    override func loadView() {
        
        //读取沙盒信息
        var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        accountPath = (accountPath as NSString).appendingPathComponent("account.plist")
        let account  = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? WBUserAccount
        //判断是否有沙盒文件
        if let account = account {
            if let expires_date = account.expires_date {
                //如果没过期，则设置login状态为true
                isLogin = (expires_date.compare(Date()) == ComparisonResult.orderedDescending)
            }
        }
        isLogin ? super.loadView() : setupVisitorView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
    }
}

// MARK:- 设置UI界面
extension WBBaseTableViewController {
    
    fileprivate func setupVisitorView() {
        view = visitorView
        visitorView.registBtn.addTarget(self, action: #selector(registBtnClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginBtnClick))
    }
}

// MARK:- 监听事件
extension WBBaseTableViewController {
    @objc fileprivate func registBtnClick() {
        CWLog()
    }
    
    @objc fileprivate func loginBtnClick() -> Void {
        let authVC = WBAuthorizeViewController()
        
        let authNavVC = UINavigationController(rootViewController: authVC)
        
        present(authNavVC, animated: true, completion: nil)
        
        
    }
}
