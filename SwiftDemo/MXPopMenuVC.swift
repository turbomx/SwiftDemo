//
//  MXPopMenuVC.swift
//  SwiftDemo
//
//  Created by turbomx on 2016/11/28.
//  Copyright © 2016年 xiazy. All rights reserved.
//


import UIKit

class MXPopMenuVC : UIViewController{
    
    var upIndex:Int = 0
    var downIndex:Int = 0
    var closeImgView:UIImageView?
    var myTimer:Timer?
    var bgImg:UIImage?
    
    lazy var itemButtons :[MXMenuButton] = {
        return []
    }()
    
    lazy var ary:Array<String> = {
        var tempAry:Array<String> = []
        for i in 18001...18006{
            tempAry.append("\(i)")
        }
        return tempAry
    }()
    
    lazy var titleAry:[String]={
        return ["学习","交流","关注","sina","围脖:","turbomx"];
    }()
    //代码生成视图
    override func loadView() {
        super.loadView()
        self.navigationItem.setHidesBackButton(true, animated: false)
        let contentView:UIView = UIView(frame: UIScreen.main.bounds)
        contentView.backgroundColor = UIColor.white
        let imgView:UIImageView = UIImageView(image: self.bgImg!)
        //创建蒙板
        let bgView:UIView = UIView(frame: UIScreen.main.bounds)
        bgView.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
        imgView.addSubview(bgView)
        contentView.addSubview(imgView)
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addMenu()
        self.addCloseImg()
        //设置定时器，弹出逐个弹出菜单按钮
        self.myTimer = Timer(timeInterval: 0.1, target: self, selector: #selector(popupBtn), userInfo: nil, repeats: true)
        //将定时器添加到运行循环
        RunLoop.current.add(myTimer!, forMode: .commonModes)
        
        let singleTap :UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backAction))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(singleTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.6, animations: {()->Void in
            self.closeImgView?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        })
    }
    
    //添加菜单按钮
    fileprivate func addMenu(){
        
        let cols:Int = 3
        var col:Int = 0
        var row:Int = 0
        var x:CGFloat = 0
        var y:CGFloat = 0
        let wh:CGFloat = 90
        let margin:CGFloat = (UIScreen.main.bounds.size.width - CGFloat(cols) * wh )/(CGFloat(cols) + 1)
        let oriY:CGFloat = 300
        
        for i in 0 ..< ary.count{
            let btn : MXMenuButton = MXMenuButton(type: .custom)
            let img :UIImage = UIImage.init(named: "\(ary[i])")!
            btn.setImage(img, for: .normal)
            btn.setTitle(titleAry[i], for: .normal)
            col = i % cols //当前列
            row = i / cols //当前行
            x = margin + CGFloat(col)*(margin+wh)
            y = CGFloat(row) * (margin + wh) + oriY
            btn.frame = CGRect(x:x,y:y,width:wh,height:wh)
            //每次都是以最初位置的中心点为起始参照
            btn.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.size.height);
            btn.tag = 1000 + i
            btn.addTarget(self, action: #selector(btnClicked(btn:)), for: .touchUpInside)
            itemButtons.append(btn)
            self.view.addSubview(btn)
        }
    }
    
    //添加closeImg
    fileprivate func addCloseImg(){
        let imgView : UIImageView = UIImageView(image: UIImage(named:"closeImg"))
        imgView.frame = CGRect(x:self.view.center.x-15 ,y:self.view.frame.height-30 ,width:30 ,height:30)
        self.view .addSubview(imgView)
        self.closeImgView = imgView
    }
    
    //菜单按钮点击事件
    func btnClicked(btn:MXMenuButton){
        switch btn.tag {
        case 1000:
            if let str = btn.titleLabel?.text{
                print(str)
            }
        case 1001:
            print(""+(btn.titleLabel?.text)!)
        case 1002:
            print(""+(btn.titleLabel?.text)!)
        case 1003:
            print(""+(btn.titleLabel?.text)!)
        case 1004:
            print(""+(btn.titleLabel?.text)!)
        case 1005:
            print(""+(btn.titleLabel?.text)!)
        default:
            print(""+(btn.titleLabel?.text)!)
        }
        UIView.animate(withDuration: 0.5, animations: {()->Void in
            btn.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }, completion: {(finished:Bool)->Void in
            //使用首尾式动画区分闭包
            UIView.beginAnimations("", context: nil)
            UIView.setAnimationDuration(0.3)
            btn.transform = .identity
            UIView.commitAnimations();
        })
    }
    //弹出菜单
    func popupBtn(){
        
        if self.upIndex == self.itemButtons.count{
            self.downIndex = self.itemButtons.count - 1
            self.myTimer?.invalidate()
            self.upIndex = 0
            return;
        }
        let tempBtn:MXMenuButton = self.itemButtons[self.upIndex]
        self.setUpOneBtnAnim(btn:tempBtn)
        self.upIndex+=1
    }
    
    //设置按钮从第一个开始向上滑动显示
    func setUpOneBtnAnim(btn:MXMenuButton){
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseIn, animations: {()->Void in
            btn.transform = .identity;
        }, completion: nil)
    }
    //返回
    func backAction(){
        self.myTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(popdownBtn), userInfo: nil, repeats: true)
        //设置关闭动画
        UIView.animate(withDuration: 0.3, animations: {()->Void in
            print(CGFloat(-M_PI_2*1.5))
            self.closeImgView?.transform = CGAffineTransform(rotationAngle:  CGFloat(-M_PI_4))
        })
    }
    //设置按钮从最后一个开始向下滑动显示
    func popdownBtn(){
        if self.downIndex == -1{
            //pop当前页面
            _ = self.navigationController?.popViewController(animated: true)
            self.myTimer?.invalidate()
            return
        }
        let tempBtn:MXMenuButton = self.itemButtons[self.downIndex]
        self.setDownOneBtnAnim(btn:tempBtn)
        self.downIndex -= 1
    }
    //设置动画
    func setDownOneBtnAnim(btn:MXMenuButton){
        UIView.animate(withDuration: 0.6, animations: {()->Void in
            btn.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.size.height)
        }, completion: nil)
    }
    //析构函数
    deinit {
        print("执行析构函数")
    }
}
