//
//  WBHomeTableViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBHomeTableViewController: WBBaseTableViewController {
    var isPresented = false
    
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
    //改变弹出View的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return WBPresentationController(presentedViewController: presented, presenting: presenting)
    }
    //改变弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    //改变消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension WBHomeTableViewController : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? animationForPresentedView(transitionContext: transitionContext) : animationForDismissView(transitionContext: transitionContext)
    }
    
}

extension WBHomeTableViewController {
    fileprivate func animationForPresentedView(transitionContext: UIViewControllerContextTransitioning) -> Void {
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        transitionContext.containerView.addSubview(presentedView)
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        presentedView.transform = CGAffineTransform(scaleX: 0.0,y: 0.0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView.transform = CGAffineTransform.identity
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    
    fileprivate func animationForDismissView(transitionContext: UIViewControllerContextTransitioning) -> Void {
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        transitionContext.containerView.addSubview(dismissView)
        dismissView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }) { (_) in
            dismissView.removeFromSuperview()
            self.titleBtn.isSelected = !self.titleBtn.isSelected
            transitionContext.completeTransition(true)
        }

    }

}
