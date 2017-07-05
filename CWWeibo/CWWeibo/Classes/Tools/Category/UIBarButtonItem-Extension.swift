//
//  UIBarButtonItem-Extension.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(image : UIImage, highlightedImage: UIImage) {
        
        let btn = UIButton(type: .custom)
        btn.setImage(image, for: .normal)
        btn.setImage(highlightedImage, for: .highlighted)
        btn.sizeToFit()
        
        self.init(customView: btn)
    }
}
