//
//  WBHomeTableViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBHomeTableViewController: WBBaseTableViewController {

    // MARK:- 懒加载
    fileprivate lazy var titleBtn : WBNavigationTitleButton = WBNavigationTitleButton()
    fileprivate lazy var popoverAnimator : WBPopoverAnimator = WBPopoverAnimator()
    // MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.addRotationAnim()
        isLogin = true
        
        guard isLogin else {
            return
        }
        
        setupNavigationBar()
    }


}


// MARK: - 初始化界面
extension WBHomeTableViewController {
    
    fileprivate func setupNavigationBar() {
        //设置左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "navigationbar_friendattention"), highlightedImage: #imageLiteral(resourceName: "navigationbar_friendattention_highlighted"))
        //设置右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "navigationbar_pop"), highlightedImage: #imageLiteral(resourceName: "navigationbar_pop_highlighted"))
        //设置中间
        titleBtn.setTitle("Coulson", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick(_:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}

// MARK:- 监听事件
extension WBHomeTableViewController {
    
    @objc fileprivate func titleBtnClick(_ button : WBNavigationTitleButton) {
        
        //弹出控制器
        let popVc = WBPopoverViewController()
        popVc.modalPresentationStyle = .custom
        
        let popverWidth : CGFloat = self.view.bounds.size.width * 0.5
        let popoverX : CGFloat = (self.view.bounds.size.width - popverWidth) * 0.5
        let popoverHeight : CGFloat = self.view.bounds.height * 0.5
        let popoverY : CGFloat = 55
        
        
        popoverAnimator.presentedFrame = CGRect(x: popoverX, y: popoverY, width: popverWidth, height: popoverHeight)
        popoverAnimator.delegate = self
        popVc.transitioningDelegate = popoverAnimator
        
        present(popVc, animated: true, completion: nil)
    }
}

extension WBHomeTableViewController : WBPopoverAnimatorDelegate {
    func statusChange(isPresented: Bool) {
        titleBtn.isSelected = isPresented
    }
}

