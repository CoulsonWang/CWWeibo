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
    
    var presentDelegate : WBPhotoBrowserAnimatorPresentDelegate?
    
    var indexPath : IndexPath?
    
}

protocol WBPhotoBrowserAnimatorPresentDelegate : NSObjectProtocol{
    func startRect(indexPath : IndexPath) -> CGRect
    
    func endRect(indexPath : IndexPath) -> CGRect
    
    func imageView(indexPath : IndexPath) -> UIImageView
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
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresented {
            animateForPrensent(transitionContext)
        } else {
            animateForDismiss(transitionContext)
        }
}
    
    private func animateForPrensent(_ transitionContext : UIViewControllerContextTransitioning) {
        
        guard let presenteDelegate = presentDelegate, let indexpath = indexPath else { return }
        
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        presentedView.isHidden = true
        transitionContext.containerView.addSubview(presentedView)
        
        let imageView = presenteDelegate.imageView(indexPath: indexpath)
        let startRect = presenteDelegate.startRect(indexPath: indexpath)
        transitionContext.containerView.addSubview(imageView)
        imageView.frame = startRect
        
        //定义动画
        transitionContext.containerView.backgroundColor = UIColor.black
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            imageView.frame = presenteDelegate.endRect(indexPath: indexpath)
        }) { (_) in
            imageView.removeFromSuperview()
            presentedView.isHidden = false
            transitionContext.containerView.backgroundColor = UIColor.clear
            transitionContext.completeTransition(true)
        }
    }
    private func animateForDismiss(_ transitionContext : UIViewControllerContextTransitioning) {
        guard let presenteDelegate = presentDelegate, let indexpath = indexPath else { return }
        
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        dismissView.isHidden = true
        
        let imageView = presenteDelegate.imageView(indexPath: indexpath)
        let startRect = presenteDelegate.endRect(indexPath: indexpath)
        transitionContext.containerView.addSubview(imageView)
        imageView.frame = startRect
        
        //定义动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            imageView.frame = presenteDelegate.startRect(indexPath: indexpath)
        }) { (_) in
            imageView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
    }
}
