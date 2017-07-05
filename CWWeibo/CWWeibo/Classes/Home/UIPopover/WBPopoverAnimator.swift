//
//  WBPopoverAnimator.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

protocol WBPopoverAnimatorDelegate {
    func statusChange(isPresented : Bool) -> Void
    
}

class WBPopoverAnimator: NSObject {
    // MARK:- 对外属性
    var isPresented : Bool = false
    var presentedFrame : CGRect = CGRect.zero
    var delegate : WBPopoverAnimatorDelegate?
}

// MARK: - UIViewControllerTransitioningDelegate
extension WBPopoverAnimator : UIViewControllerTransitioningDelegate {
    //改变弹出View的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = WBPresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.presentedFrame = presentedFrame
        
        return presentationController
    }
    //改变弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        self.delegate?.statusChange(isPresented: isPresented)
        return self
    }
    
    //改变消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        self.delegate?.statusChange(isPresented: isPresented)
        return self
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension WBPopoverAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? animationForPresentedView(transitionContext: transitionContext) : animationForDismissView(transitionContext: transitionContext)
    }
    
}

extension WBPopoverAnimator {
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
            transitionContext.completeTransition(true)
        }
    }
}
