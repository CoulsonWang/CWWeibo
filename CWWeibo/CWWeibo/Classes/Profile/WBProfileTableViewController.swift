//
//  WBProfileTableViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBProfileTableViewController: WBBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.setupVisitorViewInfo(iconImage: #imageLiteral(resourceName: "visitordiscover_image_profile"), title: "登陆后，你的微博、相册、个人资料会显示在这里、展示给别人")
    }
}
