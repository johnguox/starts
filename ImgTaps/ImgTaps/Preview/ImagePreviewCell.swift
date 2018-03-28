//
//  ImagePreviewCell.swift
//  ImgTaps
//
//  Created by 郭笑兵pro on 2018/3/15.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit

class ImagePreviewCell: UICollectionViewCell {
    
    //滚动视图
    var scrollView:UIScrollView!
    //imageView
    var imageView:UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //初始化scrollView
        self.initScreollViews()
        self.contentView.addSubview(scrollView)
        //初始化imageView
        self.initImageViews()
        self.scrollView.addSubview(imageView)
        
        //单击事件的监听
        let tapSingle = UITapGestureRecognizer(target: self, action: #selector(tapSingleDid))
        //点击次数
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        
        //双击事件的监听
        let tapDouble = UITapGestureRecognizer(target: self, action: #selector(tapDoubleDid(_:)))
        //点击次数
        tapDouble.numberOfTapsRequired = 2
        tapDouble.numberOfTouchesRequired = 1
        
        //声明点击事件需要双击事件监测失败后才会执行
        tapSingle.require(toFail: tapDouble)
        
        self.scrollView.addGestureRecognizer(tapSingle)
        self.imageView.addGestureRecognizer(tapDouble)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.resetSize()
    }
    
    //重置单元格的尺寸
    func resetSize(){
        scrollView.frame = self.contentView.bounds
        scrollView.zoomScale = 1.0
        if let image = self.imageView.image{
            imageView.frame.size = scaleSize(image.size)
            imageView.center = scrollView.center
        }
        
    }
    //获取imageView的缩放尺寸（确保首次显示是可以完整显示整张图片）
    func scaleSize(_ sizes:CGSize)->CGSize{
        let width = sizes.width
        let height = sizes.height
        
        let widthRatio = width/UIScreen.main.bounds.width
        let heightRatio = height/UIScreen.main.bounds.height
        let ratio = max(heightRatio, widthRatio)
        return CGSize(width: width/ratio, height: height/ratio)
    }
    
    @objc func tapSingleDid(_ tap:UITapGestureRecognizer){
        //显示或隐藏导航栏
        if let nav = self.responderViewController()?.navigationController{
//            nav.setNavigationBarHidden(!nav.isNavigationBarHidden, animated: true)
            nav.popViewController(animated: true)
        }
    }
    @objc func tapDoubleDid(_ taps:UITapGestureRecognizer){
        //隐藏导航栏
        if let nav = self.responderViewController()?.navigationController{
//            nav.setNavigationBarHidden(true, animated: true)
        }
        //添加动画
        UIView.animate(withDuration: 0.2, animations: {
            //如果当前不缩放，整体放大3倍，否则还原
            if self.scrollView.zoomScale == 1.0{
                //方法1
                //以中心放大三倍
//                self.scrollView.zoomScale = 3.0
                //方法2
                //以点击位置放大
                let pointInView = taps.location(in: self.imageView)
                let newZoomScale:CGFloat = 3
                let scrollViewSize = self.scrollView.bounds.size
                let w = scrollViewSize.width/newZoomScale
                let h = scrollViewSize.height/newZoomScale
                let x = pointInView.x - (w/2.0)
                let y = pointInView.y - (h/2.0)
                let rectToZoomTo = CGRect(x: x, y: y, width: w, height: h)
                self.scrollView.zoom(to: rectToZoomTo, animated: true)
            }else{
                self.scrollView.zoomScale = 1.0
            }
        })
        
    }
    
    //查找所在的VC
    func responderViewController() -> UIViewController?{
        
        for view in sequence(first: self.superview, next: {$0?.superview}) {
            if let reponder = view?.next{
                if reponder.isKind(of: UIViewController.self){
                    return reponder as? UIViewController
                }
            }
        }
        return nil
    }
    
    func initScreollViews(){
        scrollView = UIScrollView()
        scrollView.frame = self.contentView.frame
        scrollView.delegate = self
        scrollView.maximumZoomScale = 3.0
        scrollView.minimumZoomScale = 1.0
//        scrollView.isUserInteractionEnabled = true
    }
    func initImageViews(){
        imageView = UIImageView()
        imageView.frame = self.scrollView.bounds
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension ImagePreviewCell:UIScrollViewDelegate{
    
    //缩放视图
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    //缩放相应，设置ImageView的中心位置
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        var centerX = scrollView.center.x
        var centerY = scrollView.center.y
        centerX = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : centerX
        centerY = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : centerY
        imageView.center = CGPoint(x: centerX, y: centerY)
        
    }
    
}
