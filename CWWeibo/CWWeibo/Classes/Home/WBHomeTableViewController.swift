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
        button.isSelected = !button.isSelected
        
        //弹出控制器
        let popVc = WBPopoverViewController()
        popVc.modalPresentationStyle = .custom
        popVc.transitioningDelegate = self
        
        present(popVc, animated: true, completion: nil)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension WBHomeTableViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return WBPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
