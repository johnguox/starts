//
//  ImageCacheExtension.swift
//  ImgTaps
//
//  Created by 郭笑兵pro on 2018/3/17.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
  func gx_SetImage(with string:String!,placeholderImg placeholder: UIImage! = nil){
    let url = URL(string:string)!
        if placeholder == nil{
            self.sd_setImage(with: url, placeholderImage: UIImage(named:"Image1"), options: [.continueInBackground, .lowPriority], completed: nil)
        }else{
            self.sd_setImage(with: url, placeholderImage: placeholder, options: [.continueInBackground, .lowPriority], completed: nil)
        }
    
    }
    
}

extension UIButton{
    
//    func gx_Set
    
}

