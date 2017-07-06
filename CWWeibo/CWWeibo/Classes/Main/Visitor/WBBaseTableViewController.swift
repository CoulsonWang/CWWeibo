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
    
    var isLogin : Bool = WBUserAccountViewModel.sharedInstance.isLogin

    
    
    override func loadView() {
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
