//
//  MusicModel.swift
//  RxLearn
//
//  Created by 郭笑兵pro on 2018/3/13.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit
import RxSwift
struct models {
    let data = Observable.just([
        MusicModel(names: "无条件", singers: "陈奕迅"),
        MusicModel(names: "你曾经年少", singers: "S>H>E"),
        MusicModel(names: "从前的我", singers: "陈洁仪"),
        MusicModel(names: "在木星", singers: "朴树")
        ])
}

class MusicModel: NSObject {
    
    var name:String
    var singer:String
    init(names:String,singers:String){
        self.name = names
        self.singer = singers
    }
    
    
    

}
