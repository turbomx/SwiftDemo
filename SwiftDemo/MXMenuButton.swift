//
//  MXMenuButton.swift
//  SwiftDemo
//
//  Created by turbomx on 2016/11/28.
//  Copyright © 2016年 xiazy. All rights reserved.
//

import UIKit
open class MXMenuButton:UIButton{
    override init(frame:CGRect){
        super.init(frame: frame)
        self.imageView?.contentMode = .center
        self.titleLabel?.textAlignment = .center
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        let imageX:CGFloat = 0
        let imageY:CGFloat = 0
        let imageW:CGFloat = self.bounds.size.width
        let imageH:CGFloat = self.bounds.size.height * 0.8
        self.imageView?.frame = CGRect(x:imageX,y:imageY,width:imageW,height:imageH)
        
        let labelY:CGFloat = imageH
        let labelH:CGFloat = self.bounds.size.height - labelY
        self.titleLabel?.frame = CGRect(x:imageX,y:labelY,width:imageW,height:labelH)
        
    }
    
}

