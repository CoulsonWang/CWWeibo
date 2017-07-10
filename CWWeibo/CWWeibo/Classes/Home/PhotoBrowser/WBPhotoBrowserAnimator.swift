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
    
    weak var presentDelegate : WBPhotoBrowserAnimatorPresentDelegate?
    
    var indexPath : IndexPath?
    
    weak var dismissDelegate : WBPhotoBrowserAnimatorDismissDelegate?
    
}

protocol WBPhotoBrowserAnimatorPresentDelegate : NSObjectProtocol{
    func startRect(indexPath : IndexPath) -> CGRect
    
    func endRect(indexPath : IndexPath) -> CGRect
    
    func imageView(indexPath : IndexPath) -> UIImageView
}

protocol WBPhotoBrowserAnimatorDismissDelegate : NSObjectProtocol {
    func getTheIndexPath() -> IndexPath
    
    func imageView() -> UIImageView
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
        
        guard let presentDelegate = presentDelegate, let indexPath = indexPath else { return }
        
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        presentedView.isHidden = true
        transitionContext.containerView.addSubview(presentedView)
        
        let imageView = presentDelegate.imageView(indexPath: indexPath)
        let startRect = presentDelegate.startRect(indexPath: indexPath)
        transitionContext.containerView.addSubview(imageView)
        imageView.frame = startRect
        
        //定义动画
        transitionContext.containerView.backgroundColor = UIColor.black
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            imageView.frame = presentDelegate.endRect(indexPath: indexPath)
        }) { (_) in
            imageView.removeFromSuperview()
            presentedView.isHidden = false
            transitionContext.containerView.backgroundColor = UIColor.clear
            transitionContext.completeTransition(true)
        }
    }
    private func animateForDismiss(_ transitionContext : UIViewControllerContextTransitioning) {
        guard let dismissDelegate = dismissDelegate, let presentDelegate = presentDelegate else { return }
        
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        dismissView.isHidden = true
        
        let imageView = dismissDelegate.imageView()
        transitionContext.containerView.addSubview(imageView)
        let indexPath = dismissDelegate.getTheIndexPath()
        
        
        //定义动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            imageView.frame = presentDelegate.startRect(indexPath: indexPath)
        }) { (_) in
            imageView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
    }
}
