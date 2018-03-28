//
//  SliderViewController.swift
//  ImgTaps
//
//  Created by 郭笑兵pro on 2018/3/17.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit
//import SDWebImage
//屏幕宽度
let KScreenWidth = UIScreen.main.bounds.size.width
//滚动的频率(3秒滚动一次)
let rollingTime = 3
//代理协议
protocol SliderDelegate:NSObjectProtocol{
    //数据源
    func sliderDataSource()->[String]
    //获取屏幕尺寸的宽高
    func sliderSize()->CGSize
}

class SliderViewController: UIViewController {

   weak var delegate:SliderDelegate?
    //当前图片的索引
    var currentIndex:Int = 0
    //数据源
    var dataSource:[String]?
    //创建三个imageView用于轮播
    var  leftImageView,middleImageView,rightImageView:UIImageView?
    //创建滚动视图
    var scrollerView:UIScrollView?
    //滚动视图的宽和高
    var scrollerViewWidth:CGFloat?
    var scrollerViewHeight:CGFloat?
    //页控制器
    var pageControl:UIPageControl?
    //占位图
    var placeHolderImage:UIImage!
    //倒计时
    var autoScrollTimer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let size = self.delegate?.sliderSize()
        self.scrollerViewWidth = size?.width
        self.scrollerViewHeight = size?.height
        
        //获取数据
        self.dataSource = self.delegate?.sliderDataSource()
        //初始化滚动视图
        self.initScrollView()
        //初始化imageVIew
        self.initImageViews()
        self.initPages()
        self.initConfigerTimer()
        
        view.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
    }
    func initScrollView(){
        
        self.scrollerView = UIScrollView(frame: CGRect(x: 0, y: 0, width: scrollerViewWidth!, height: scrollerViewHeight!))
        self.scrollerView?.backgroundColor = UIColor.red
        self.scrollerView?.delegate = self
        self.scrollerView?.contentSize = CGSize(width: self.scrollerViewWidth!*3.0, height: self.scrollerViewHeight!)
        //滚动视图向左偏移一个View的宽度
        self.scrollerView?.contentOffset = CGPoint(x: self.scrollerViewWidth!, y: 0)
        self.scrollerView?.isPagingEnabled = true
        self.scrollerView?.bounces = false
        self.view.addSubview(self.scrollerView!)
        
        
    }
    //初始化imageView
    func initImageViews(){
        self.leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.scrollerViewWidth!, height: self.scrollerViewHeight!))
        self.middleImageView = UIImageView(frame: CGRect(x: self.scrollerViewWidth!, y: 0, width: self.scrollerViewWidth!, height: self.scrollerViewHeight!))
        self.rightImageView = UIImageView(frame: CGRect(x: self.scrollerViewWidth!*2.0, y: 0, width: self.scrollerViewWidth!, height: self.scrollerViewHeight!))
        self.scrollerView?.showsHorizontalScrollIndicator = false
        if self.dataSource?.count != 0{
            self.resetImageViewSource()
        }
        self.scrollerView?.addSubview(leftImageView!)
        self.scrollerView?.addSubview(middleImageView!)
        self.scrollerView?.addSubview(rightImageView!)
        
    }
    
    //初始化页控制器
    func initPages(){
        self.pageControl = UIPageControl(frame: CGRect(x: KScreenWidth/2-60, y: self.scrollerViewHeight!-20, width: 120, height: 20))
        self.pageControl?.numberOfPages = (self.dataSource?.count)!
        self.pageControl?.isUserInteractionEnabled = false
        self.view.addSubview(self.pageControl!)
        
    }
    //初始化定时器
    func initConfigerTimer(){
        autoScrollTimer = Timer.scheduledTimer(timeInterval: TimeInterval(rollingTime), target: self, selector: #selector(letItScroll), userInfo: nil, repeats: true)
    }
    
    @objc func letItScroll(){
        let offSet = CGPoint(x: 2.0*scrollerViewWidth!, y: 0)
        self.scrollerView?.setContentOffset(offSet, animated: true)
        
    }
    //每当各个ImageView滚动后重新设置
    func resetImageViewSource(){
        //当前显示的是第一张图片
        if self.currentIndex == 0{
            self.leftImageView?.gx_SetImage(with: self.dataSource!.last!)
            self.middleImageView?.gx_SetImage(with: self.dataSource!.first!)
            let rightImageIndex = (self.dataSource?.count)!>1 ? 1 : 0
            self.rightImageView?.gx_SetImage(with: self.dataSource![rightImageIndex])
            
        }else if self.currentIndex == ((self.dataSource?.count)! - 1){
            //当前显示的是最后一张图片
            self.leftImageView?.gx_SetImage(with: self.dataSource![self.currentIndex-1])
            self.middleImageView?.gx_SetImage(with: self.dataSource!.last)
            self.rightImageView?.gx_SetImage(with: self.dataSource!.first)
        }else{
            self.leftImageView?.gx_SetImage(with: self.dataSource![self.currentIndex-1])
            self.middleImageView?.gx_SetImage(with: self.dataSource![self.currentIndex])
            self.rightImageView?.gx_SetImage(with: self.dataSource![self.currentIndex+1])
        }
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SliderViewController:UIScrollViewDelegate{
    
    //scrollView滚动完毕后触发
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //获取当前的偏移量
        let offset = scrollView.contentOffset.x
        if (self.dataSource!.count != 0){
            //如果向左滑动（显示下一张）
            if (offset >= self.scrollerViewWidth!*2.0){
                //还原偏移量
                scrollView.contentOffset = CGPoint(x: self.scrollerViewWidth!, y: 0)
                //视图索引+1
                self.currentIndex = self.currentIndex+1
                if self.currentIndex == self.dataSource?.count{
                    self.currentIndex = 0
                }
            }
            //如果向右滑动（显示上一张）
            if (offset <= 0){
                //还原偏移量
                scrollView.contentOffset = CGPoint(x: self.scrollerViewWidth!, y: 0)
                //视图索引-1
                self.currentIndex = self.currentIndex - 1
                if self.currentIndex == -1{
                    self.currentIndex = (self.dataSource?.count)! - 1
                }
            }
            //重设各个imageView的图片
            resetImageViewSource()
            //设置页控制器当前页码
            self.pageControl?.currentPage = self.currentIndex
        }
    }
    //手动拖拽滚动开始
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //计时器失效
        autoScrollTimer?.invalidate()
    }
    //手动拖拽滚动结束
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //重新启动定时器
        initConfigerTimer()
    }
    //重新加载数据
    func reloadData(){
        self.currentIndex = 0
        self.dataSource = self.delegate?.sliderDataSource()
        self.pageControl?.numberOfPages = (self.dataSource?.count)!
        self.pageControl?.currentPage = 0
        //重新设置各个imageView的图片
        resetImageViewSource()
    }
    
}
