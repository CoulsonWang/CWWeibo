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
        isLogin ? super.loadView() : setupVisitorView()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

extension WBBaseTableViewController {
    
    fileprivate func setupVisitorView() {
        view = visitorView
    }
}
