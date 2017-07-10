//
//  WBPhotoBrowserAnimator.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/10.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBPhotoBrowserAnimator: NSObject {
    var isPresented : Bool = false
    
}

extension WBPhotoBrowserAnimator : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}

extension WBPhotoBrowserAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresented {
            animateForPrensent(transitionContext)
        } else {
            animateForDismiss(transitionContext)
        }
}
    
    private func animateForPrensent(_ transitionContext : UIViewControllerContextTransitioning) {
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        transitionContext.containerView.addSubview(presentedView)
        
        //定义动画
        presentedView.alpha = 0.0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView.alpha = 1.0
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    private func animateForDismiss(_ transitionContext : UIViewControllerContextTransitioning) {
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        transitionContext.containerView.addSubview(dismissView)
        
        //定义动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissView.alpha = 0.0
        }) { (_) in
            dismissView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
    }
}
