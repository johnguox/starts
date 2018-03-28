//
//  SectonderViewController.swift
//  ImgTaps
//
//  Created by 郭笑兵pro on 2018/3/20.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit

class SectonderViewController: UIViewController {

    lazy var backBtn:UIButton = {
       let btn = UIButton()
        btn.setTitle("返回方式1", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.frame = CGRect(x: 20, y: 100, width: 80, height: 30)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "第二页"
        self.view.backgroundColor = UIColor.white
        
        
        self.view.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(clickBackBtn), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    @objc func clickBackBtn(){
//        self.navigationController?.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
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
