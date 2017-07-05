//
//  WBPresentationController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBPresentationController: UIPresentationController {
    
    fileprivate lazy var coverView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        let width : CGFloat = 200
        let height : CGFloat = 300.0
        let x = (self.containerView!.bounds.size.width - width) * 0.5
        
        presentedView?.frame = CGRect(x: x, y: 55, width: width, height: height)
        setupCoverView()
        
    }
}

extension WBPresentationController {
    fileprivate func setupCoverView() {
        containerView?.insertSubview(coverView, at: 0)
        coverView.backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        coverView.frame = containerView!.bounds
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(coverViewClick))
        coverView.addGestureRecognizer(tap)
    }
}

// MARK: - 监听事件
extension WBPresentationController {
    @objc fileprivate func coverViewClick() -> Void {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
