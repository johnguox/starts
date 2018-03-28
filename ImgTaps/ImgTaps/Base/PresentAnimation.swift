//
//  PresentAnimation.swift
//  ImgTaps
//
//  Created by 郭笑兵pro on 2018/3/20.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit

class PresentAnimation: NSObject ,UIViewControllerAnimatedTransitioning{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
//        let fromeViewController = transitionContext.viewController(forKey: .from)
        var destView:UIView!
        let destTransfrom = CGAffineTransform()
        let screenHeight = UIScreen.main.bounds.size.height
        destView = toViewController?.view
        destView.transform = CGAffineTransform(translationX: 0, y: screenHeight)
        containerView.addSubview((toViewController?.view)!)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            destView.transform = destTransfrom
        }) { (completed) in
            transitionContext.completeTransition(true)
        }
//        let containerView = transitionContext.containerView
//
//        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
//        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
//
//        var destView: UIView!
//        var destTransfrom = CGAffineTransform()
//        let screenHeight = UIScreen.main
//            .bounds.size.height
//
//
//        destView = toViewController?.view
//        destView.transform = CGAffineTransform(translationX: 0, y: screenHeight)
//        containerView.addSubview((toViewController?.view)!)
//
//        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0,
//                       options: UIViewAnimationOptions.curveLinear, animations: {
//                        destView.transform = destTransfrom
//        }, completion: {completed in
//            transitionContext.completeTransition(true)
//        })
    }
    
    
}
