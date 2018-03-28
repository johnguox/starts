//
//  FlipPresentAnimationController.swift
//  ImgTaps
//
//  Created by 郭笑兵pro on 2018/3/19.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit
import Foundation

class FlipPresentAnimationController: NSObject ,UIViewControllerAnimatedTransitioning{
    var originFrame = CGRect.zero
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from),let toVC = transitionContext.viewController(forKey: .to)else{
            return
        }
        let initialFrame = originFrame
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        let snpShot = toVC.view.snapshotView(afterScreenUpdates: true)!
        snpShot.frame = initialFrame
        snpShot.layer.cornerRadius = 25
        snpShot.layer.masksToBounds = true
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snpShot)
        toVC.view.isHidden = true
        AnimationHelper.perspectiveTransformForContainerView(containerView)
        snpShot.layer.transform = AnimationHelper.yRotation(Double.pi/2)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                fromVC.view.layer.transform = AnimationHelper.yRotation(-Double.pi/2)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                snpShot.layer.transform = AnimationHelper.yRotation(0.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                snpShot.frame = finalFrame
            })
        }, completion: { _ in
            toVC.view.isHidden = false
            fromVC.view.layer.transform = AnimationHelper.yRotation(0.0)
            snpShot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
        
    }
    
    

}
