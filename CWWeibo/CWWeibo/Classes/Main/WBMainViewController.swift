//
//  WBMainViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {
    
    fileprivate lazy var publishButton = UIButton(type: UIButtonType.custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPublishButton()
    }
    

}

extension WBMainViewController {
    
    /// 设置发布按钮
    fileprivate func setupPublishButton() -> Void {
        tabBar.addSubview(publishButton)
        
        publishButton.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button"), for: .normal)
        publishButton.setBackgroundImage(#imageLiteral(resourceName: "tabbar_compose_button_highlighted"), for: .highlighted)
        publishButton.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add"), for: .normal)
        publishButton.setImage(#imageLiteral(resourceName: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        publishButton.sizeToFit()
        publishButton.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
    }
}
