//
//  PushAnimation.swift
//  ImgTaps
//
//  Created by 郭笑兵pro on 2018/3/20.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit

class PushAnimation: NSObject ,UIViewControllerAnimatedTransitioning{
    //动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        var destView: UIView!
        var destTransform: CGAffineTransform!
        containerView.insertSubview((toViewController?.view)!, aboveSubview: (fromViewController?.view)!)
        destView = toViewController?.view
        destView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        destTransform = CGAffineTransform(scaleX: 1, y: 1)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destView.transform = destTransform
        }, completion: ({completed in
            transitionContext.completeTransition(true)
        }))
    }
    

}
