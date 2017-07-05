//
//  WBMessageTableViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBMessageTableViewController: WBBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.setupVisitorViewInfo(iconImage: #imageLiteral(resourceName: "visitordiscover_image_message"), title: "登陆后，别人评论你的微博，给你发的消息，都会在这里收到通知")
    }

    

}
