//
//  ViewController.swift
//  SwiftDemo
//
//  Created by turbomx on 2016/11/26.
//  Copyright © 2016年 xiazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var footView: UIView!
    @IBOutlet weak var popBtn: UIButton!
    
    @IBAction func popBtnClicked(_ sender: Any) {
        let bgImg :UIImage? = UIImage.imageWithCaptureView(view: self.view)
        let popVC : MXPopMenuVC = MXPopMenuVC()
        popVC.bgImg = bgImg
        self.navigationController?.pushViewController(popVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        let bgImgView :UIImageView = UIImageView(image: UIImage(named:"bg.png")!)
        bgImgView.frame = UIScreen.main.bounds
        self.view.insertSubview(bgImgView, belowSubview: self.footView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIImage{
    //截屏
    class func imageWithCaptureView(view:UIView)->UIImage?{
        let size:CGSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height-40)
        //开启位图上下文
        UIGraphicsBeginImageContextWithOptions(size,false, 0)
        //获取上下文
        let ctx :CGContext? = UIGraphicsGetCurrentContext()
        //把控件的图层渲染到上下文，layer只能渲染
        view.layer .render(in: ctx!)
        //生成新图片
        let image:UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        return image;
    }
}




