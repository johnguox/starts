//
//  AnimationHelper.swift
//  ImgTaps
//
//  Created by 郭笑兵pro on 2018/3/19.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import Foundation
import UIKit

struct AnimationHelper {
    static func yRotation(_ angle: Double) -> CATransform3D {
        return CATransform3DMakeRotation(CGFloat(angle), 0.0, 1.0, 0.0)
    }
    
    static func perspectiveTransformForContainerView(_ containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
    }
}


