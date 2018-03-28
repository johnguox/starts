//
//  ViewController.swift
//  ImgTaps
//
//  Created by 郭笑兵pro on 2018/3/15.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit

class ViewController: BaseViewController,SliderDelegate {

//    let images = ["Image1","Image2","Image3","Image4","Image5"]
    
    var images = ["http://img4q.duitang.com/uploads/item/201503/18/20150318230437_Pxnk3.jpeg",
                  "http://img4.duitang.com/uploads/item/201501/31/20150131234424_WRJGa.jpeg",
                  "http://img5.duitang.com/uploads/item/201502/11/20150211095858_nmRV8.jpeg",
                  "http://cdnq.duitang.com/uploads/item/201506/11/20150611213132_HPecm.jpeg"]
    var slider:SliderViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "首页"
        self.view.backgroundColor = UIColor.white
        if #available(iOS 11, *){
            
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        //修改导航栏返回按钮文字
        let item = UIBarButtonItem(title: "返回", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item;
        
//        //生成缩略图
//        for i in 0..<images.count{
//            //创建ImageView
//            let imageView = UIImageView()
//            imageView.frame = CGRect(x:20+i*70, y:80, width:60, height:60)
//            imageView.tag = i
//            imageView.contentMode = .scaleAspectFill
//            imageView.clipsToBounds = true
//            imageView.image = UIImage(named: images[i])
//            //设置允许交互（后面要添加点击）
//            imageView.isUserInteractionEnabled = true
//            self.view.addSubview(imageView)
//            //添加单击监听
//            let tapSingle=UITapGestureRecognizer(target:self,
//                                                 action:#selector(imageViewTap(_:)))
//            tapSingle.numberOfTapsRequired = 1
//            tapSingle.numberOfTouchesRequired = 1
//            imageView.addGestureRecognizer(tapSingle)
//        }
        
        
        //初始化
        slider = SliderViewController()
        slider.delegate = self
        slider.view.frame = CGRect(x: 10, y: 40, width: KScreenWidth-20, height: (KScreenWidth-20)/4*3)
        self.addChildViewController(slider)
        self.view.addSubview(slider.view)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapAction(_:)))
        slider.view.addGestureRecognizer(tap)
        
    }
    
    //轮播的尺寸
    func sliderSize() -> CGSize {
        return CGSize(width: KScreenWidth-20, height: (KScreenWidth-20)/4*3)
    }
    func sliderDataSource() -> [String] {
        return images
    }
    
    
    @objc func handleTapAction(_ tap:UITapGestureRecognizer){
        print(slider.currentIndex)
//        let vc = ImagePreviewViewController(images: images, index: slider.currentIndex)
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let vc = SectonderViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
        
    }
    
//    //缩略图imageView点击
//    @objc func imageViewTap(_ recognizer:UITapGestureRecognizer){
//        //图片索引
//        let index = recognizer.view!.tag
//        //进入图片全屏展示
//        let previewVC = ImagePreviewViewController(images: images, index: index)
//        self.navigationController?.pushViewController(previewVC, animated: true)
//    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

