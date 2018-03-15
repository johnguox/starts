//
//  FirstViewController.swift
//  RxLearn
//
//  Created by 郭笑兵pro on 2018/3/13.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FirstViewController: BaseViewController {

//    lazy var tv:UITableView = UITableView()
//    let model = models()
    
//    lazy var labs:UILabel = UILabel()
//    lazy var textfi:UITextField = UITextField()
    
    lazy var btn:UIButton = UIButton()
    
    
    let dispone = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "第一天"
        
//        view.addSubview(tv)
//        tv.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
//        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Musixcell")
//        model.data.bind(to: tv.rx.items(cellIdentifier: "Musixcell")) { _ , music ,cell in
//            cell.textLabel?.text = music.name
//            cell.detailTextLabel?.text = music.singer
//        }.disposed(by: dispone)
//
//        tv.rx.modelSelected(MusicModel.self).subscribe(onNext: { music in
//            print("你选中的歌曲信息【\(music.name)】")
//        }).disposed(by: dispone)
//
////
//        let observer:AnyObserver<String> = AnyObserver { (event) in
//            switch event{
//            case .next(let data):
//                print(data)
//            case .error(let error):
//                print(error)
//            case .completed:
//                print("完成点击事件！！！！")
//            }
//        }
//
//        let observable = Observable.of("A","B","C","D")
//
//        observable.subscribe(observer)
//        labs.numberOfLines = 0
//        labs.font = UIFont.systemFont(ofSize: 15)
//
//        self.view.addSubview(labs)
//        self.view.addSubview(textfi)
//        textfi.backgroundColor = UIColor.red
//
//        let input = textfi.rx.text.orEmpty.asDriver().throttle(0.3)
//        input.drive(textfi.rx.text).disposed(by: dispone)
//        input.drive(labs.rx.text).disposed(by: dispone)
        
        btn.backgroundColor = UIColor.red
//        btn.setTitle("点击事件", for: .normal)
        
        self.view.addSubview(self.btn)
        //绑定点击事件
        btn.rx.tap.bind{ [weak self] in
            self?.creatViews()
        }.disposed(by: dispone)
        
        //创建观察者
//        let observable = Observable.just("点击事件")
        let observable = Observable.just(UIImage(named:"placeImg"))
//        observable.bind(to: btn.rx.title(for: .normal)).disposed(by: dispone)
        observable.bind(to: btn.rx.image()).disposed(by: dispone)
        
//        btn.rx.tap
//            .subscribe(onNext:{ [weak self] in
//                self?.creatViews()
//            })
//            .disposed(by: dispone)
        
        

        
        // Do any additional setup after loading the view.
    }
    func creatViews(){
         print("点击事件！！！！")
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
//        labs.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview().inset(10)
//            make.top.equalToSuperview().inset(64)
//
//        }
//        textfi.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview().inset(10)
//            make.top.equalTo(labs.snp.bottom).offset(30)
//            make.height.equalTo(50)
//        }
        btn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(84)
            make.width.height.equalTo(80)
        }
        
        
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
