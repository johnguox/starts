//
//  ViewController.swift
//  WebViews
//
//  Created by 郭笑兵pro on 2018/3/27.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {

    lazy var webs:UIWebView = {
        let webs = UIWebView()
        webs.delegate = self
        webs.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 90)
        return webs
    }()
    lazy var hea:UIView = {
       
        let vi = UIView()
        vi.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100)
        vi.backgroundColor = UIColor.red
        return vi
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
         <p><img src="http://sys.hbylykt.com:80/static/upload/goodsDetail/20170817/1502982537400001930.jpg" title="1502982537400001930.jpg" alt="bobo凤梨.jpg"/></p><style> img{max-width: 100%;} </style>
         */
        
        view.addSubview(hea)
        hea.addSubview(webs)
        let url = URL(string:"https://www.baidu.com")
        let req = URLRequest(url: url!)
//        webs.loadHTMLString(stri, baseURL: nil)
        webs.loadRequest(req)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //方法1
        let webHeights = webView.scrollView.contentSize.height
        print(webHeights)
        self.webs.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: webHeights)
        self.hea.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: webHeights+10)
        //方法二
        //通过JS方法获取webView的高度
        let height = (webView.stringByEvaluatingJavaScript(from: "document.body.offsetHeight")as! NSString).floatValue
        print(height)
        //方法三
        let webSize = webView.sizeThatFits(CGSize.zero)
//        let rect = webView.frame
        print(webSize.height)
        
        
        
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("加载失败！！！")
    }
    //是否允许网页的加载
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

