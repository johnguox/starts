//
//  SecondViewController.swift
//  RxLearn
//
//  Created by 郭笑兵pro on 2018/3/14.
//  Copyright © 2018年 郭笑兵pro. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SecondViewController: BaseViewController {

    //销毁对象
    let disposeBag = DisposeBag()
    //datePicker
    var pick:UIDatePicker!
    lazy var lab:UILabel = UILabel()
    lazy var formatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
        return formatter
    }()
    
    lazy var btnSatrt:UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .disabled)
        
        return btn
    }()
    
    //剩余时间
    let leftTime = Variable(TimeInterval(60))
    //倒计时是否结束
    let countDownStopped = Variable(true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "第二天"
        
//        //手势的绑定
//        let swipe = UISwipeGestureRecognizer()
//        swipe.direction = .up
//        self.view.addGestureRecognizer(swipe)
        
        //方法1
//        swipe.rx.event.bind { [weak self] recognizer in
//
//            let point = recognizer.location(in: recognizer.view)
//            self?.showAlerts("\(point.x)   \(point.y)")
//        }.disposed(by: disposeBag)
        //方法2
//        swipe.rx.event.subscribe(onNext: { [weak self] recognizer in
//            let point = recognizer.location(in: recognizer.view)
//            self?.showAlerts("\(point.x)   \(point.y)")
//        }).disposed(by: disposeBag)
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.numberOfLines = 0
        self.pick = UIDatePicker()
        self.view.addSubview(pick)
        self.view.addSubview(lab)
        self.view.addSubview(btnSatrt)
        
        pick.datePickerMode = .countDownTimer
        
        
        
//        pick.rx.date.map { [weak self]  in
//            "当前选择时间:" + self!.formatter.string(from: $0)
//        }.bind(to: lab.rx.text).disposed(by: disposeBag)
        
        //剩余时间与datePicker做双向绑定
        DispatchQueue.main.async {
            //<->双向绑定符号需要自定义 Operators
            _ = self.pick.rx.countDownDuration <-> self.leftTime
        }
        
        //绑定button标题
        Observable.combineLatest(leftTime.asObservable(), countDownStopped.asObservable()) { leftTimeValue, countDownStoppedValue in
            if countDownStoppedValue{
                return "开始"
            }else{
                return "倒计时开始，还有\(Int(leftTimeValue))秒。。"
            }
        }.bind(to: btnSatrt.rx.title()).disposed(by: disposeBag)
        
        
        //绑定button和datePicker状态（在倒计时过程中，按钮和时间选择组件不可用）
        countDownStopped.asDriver().drive(pick.rx.isEnabled).disposed(by: disposeBag)
        countDownStopped.asDriver().drive(btnSatrt.rx.isEnabled).disposed(by: disposeBag)
        
        //绑定按钮的点击事件
        btnSatrt.rx.tap.bind{ [weak self] in
            //开启倒计时
            self?.startClicked()
        }.disposed(by: disposeBag)
        
        
        
        // Do any additional setup after loading the view.
    }
    func startClicked(){
        
        self.countDownStopped.value = false
        Observable<Int>.interval(1, scheduler: MainScheduler.instance).takeUntil(countDownStopped.asObservable().filter{$0}).subscribe { event in
            self.leftTime.value -= 1
            if (self.leftTime.value == 0){
                self.countDownStopped.value = true
                self.leftTime.value = 120
            }
        }.disposed(by: disposeBag)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        pick.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().inset(64)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        lab.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(pick.snp.bottom).offset(20)
        }
        
        btnSatrt.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview().inset(40)
//            make.top.equalTo(lab.snp.bottom).offset(10)
//            make.height.equalTo(40)
            make.edges.equalTo(lab)
        }
        
        
    }
    
    
    func showAlerts(_ message:String){
        let alertVC = UIAlertController(title: "向上滑动", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
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
