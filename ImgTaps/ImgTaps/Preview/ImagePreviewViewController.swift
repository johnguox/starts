//
//  ImagePreviewViewController.swift
//  ImgTaps
//
//  Created by 郭笑兵pro on 2018/3/15.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit

class ImagePreviewViewController: BaseViewController {
    //图片数组
    var images:[String]
    //默认显示的图片索引
    var index:Int
    //显示图片的单元格
    var collectionView:UICollectionView!
    //collectionView的布局
    var collectionViewLayout:UICollectionViewFlowLayout!
    //pageController页控制器
    var pageControl:UIPageControl!
    //初始化
    init(images:[String],index:Int = 0){
        self.images = images
        self.index = index
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        //collectionView尺寸样式设置
       self.initCollectionViewLayouts()
        //初始化collectionView
        self.initCollectionViews()
        if #available(iOS 11, *){
            self.collectionView.contentInsetAdjustmentBehavior = .never
        }else{
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.addSubview(self.collectionView)
        
        //将视图滚动到默认的图片上
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        
        
        //初始化页控制器
        self.initPageControllers()
        view.addSubview(pageControl)
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //重设collectionView的尺寸
        collectionView.frame.size = self.view.frame.size
        collectionView.collectionViewLayout.invalidateLayout()
        //将视图滚动到当前图片
        let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        //重新设置页控制器的位置
        pageControl.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height-20)
    }
    
    
    func initCollectionViewLayouts(){
        collectionViewLayout = UICollectionViewFlowLayout()
        //cell的间距
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        //滚动方向
        collectionViewLayout.scrollDirection = .horizontal
    }
    func initCollectionViews(){
        
        self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.black
        collectionView.register(ImagePreviewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
    }
    func initPageControllers(){
        pageControl = UIPageControl()
        pageControl.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height-20)
        pageControl.numberOfPages = images.count
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPage = index
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ImagePreviewViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! ImagePreviewCell
//        let image = UIImage(named:self.images[indexPath.row])
//        cell.imageView.image = image
        cell.imageView.gx_SetImage(with: self.images[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    //单元格的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.bounds.size
    }
    //某个单元格将要显示
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? ImagePreviewCell{
            cell.resetSize()
        }
    }
    //显示完毕的操作
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //当前显示的单元格
        let visibleCell = collectionView.visibleCells[0]
        self.pageControl.currentPage = collectionView.indexPath(for: visibleCell)!.item
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        collectionView.deselectItem(at: indexPath, animated: true)
//        print(indexPath.row)
//    }
    
    
}

