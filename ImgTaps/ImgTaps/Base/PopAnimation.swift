//
//  PopAnimation.swift
//  ImgTaps
//
//  Created by 郭笑兵pro on 2018/3/20.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit

class PopAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        var destView: UIView!
        var destTransform: CGAffineTransform!
        containerView.insertSubview((toViewController?.view)!, belowSubview: (fromViewController?.view)!)
        destView = fromViewController?.view
        // 如果IDE是Xcode6 Beta4+iOS8SDK，那么在此处设置为0，动画将不会被执行(不确定是哪里的Bug)
        destTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destView.transform = destTransform
        }, completion: ({completed in
            transitionContext.completeTransition(true)
        }))
    }

}
