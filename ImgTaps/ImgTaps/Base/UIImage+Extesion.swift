//
//  UIImage+Extesion.swift
//  ImgTaps
//
//  Created by 郭笑兵pro on 2018/3/19.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import Foundation
import UIKit


extension UIImage{
    
    class func renderImage(from view:UIView)->UIImage?{
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size,true,0)
    
    let context=UIGraphicsGetCurrentContext()
    
    view.layer.render(in:context!)
    
    let renderedImage=UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return renderedImage
    }
    
}


