//
//  ViewController.swift
//  RxLearn
//
//  Created by 郭笑兵pro on 2018/3/13.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func firstActions(_ sender: Any) {
        
        let vc = FirstViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func secondActions(_ sender: Any) {
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

