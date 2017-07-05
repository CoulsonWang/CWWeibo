//
//  WBMainViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBMainViewController: UITabBarController {
    // MARK:- 懒加载
    fileprivate lazy var publishButton = UIButton(image: #imageLiteral(resourceName: "tabbar_compose_icon_add"), highlightedImage: #imageLiteral(resourceName: "tabbar_compose_icon_add_highlighted"), backgroundImage: #imageLiteral(resourceName: "tabbar_compose_button"), highlightedBackgroundImage: #imageLiteral(resourceName: "tabbar_compose_button_highlighted"))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPublishButton()
    }
    

}

extension WBMainViewController {
    
    /// 设置发布按钮
    fileprivate func setupPublishButton() -> Void {
        tabBar.addSubview(publishButton)
        
        publishButton.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        
        publishButton.addTarget(self, action: #selector(publishBtnClick), for: .touchUpInside)
    }
}
// MARK:- 事件监听
extension WBMainViewController {
    @objc fileprivate func publishBtnClick() -> Void {
        CWLog("")
    }
}
