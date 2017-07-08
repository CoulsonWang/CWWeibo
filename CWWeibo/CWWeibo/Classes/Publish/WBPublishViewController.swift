//
//  WBPublishViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/8.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBPublishViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
    }

}
// MARK:- 初始化界面
extension WBPublishViewController {
    fileprivate func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelPublish))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(sendPublish))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        navigationItem.titleView = WBPublishTitleView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
    }
}

// MARK:- 监听事件
extension WBPublishViewController {
    @objc fileprivate func cancelPublish() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func sendPublish() {
        
    }
}

