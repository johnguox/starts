//
//  ViewController.swift
//  drawingImg
//
//  Created by 郭笑兵pro on 2018/3/15.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    lazy var orginalImg:UIImage = {
        let img = UIImage(named:"Imag")!
        return img
    }()
    lazy var context:CIContext = {
        return CIContext(options: nil)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = orginalImg
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func normalAction(_ sender: Any) {
        imgView.image = orginalImg
        
    }
    
    @IBAction func selectedAction(_ sender: Any) {
        
        let cgImg = context.createCGImage(self.creatOutImg(), from: self.creatOutImg().extent)
        imgView.image = UIImage(cgImage: cgImg!)
        
    }
    
    //抠图
    func creatOutImg()->CIImage{
        let cubeMap = createCubeMap(210, 240)
        let data = NSData(bytesNoCopy: cubeMap.data, length: Int(cubeMap.length), freeWhenDone: true)
        //消除某种颜色
        let colorCubeFilter = CIFilter(name:"CIColorCube")
        colorCubeFilter?.setValue(cubeMap.dimension, forKey: "inputCubeDimension")
        colorCubeFilter?.setValue(data, forKey: "inputCubeData")
        colorCubeFilter?.setValue(CIImage(image:orginalImg), forKey: kCIInputImageKey)
        let outPutImage = colorCubeFilter?.outputImage
        return outPutImage!
    }
    
    @IBAction func allActions(_ sender: Any) {
        //合成图像
        let soureOverCompositingFilter = CIFilter(name: "CISourceOverCompositing")!
        soureOverCompositingFilter.setValue(self.creatOutImg(), forKey: kCIInputImageKey)
        soureOverCompositingFilter.setValue(CIImage(image:UIImage(named:"bgImg")!), forKey: kCIInputBackgroundImageKey)
        
        let cc = soureOverCompositingFilter.outputImage!
        let cgImge = context.createCGImage(cc, from: cc.extent)
        imgView.image = UIImage(cgImage: cgImge!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

