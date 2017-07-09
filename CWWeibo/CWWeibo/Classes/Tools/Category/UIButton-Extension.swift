//
//  UIButton-Extension.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

extension UIButton {
    /// 便利构造函数
    convenience init(image : UIImage, highlightedImage : UIImage, backgroundImage : UIImage, highlightedBackgroundImage : UIImage) {
        self.init()
        setImage(image, for: .normal)
        setImage(highlightedImage, for: .highlighted)
        setBackgroundImage(backgroundImage, for: .normal)
        setBackgroundImage(highlightedImage, for: .highlighted)
        sizeToFit()
    }
    
    convenience init(backgroundColor: UIColor, fontSize: CGFloat, title: String) {
        self.init()
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
    }
}
