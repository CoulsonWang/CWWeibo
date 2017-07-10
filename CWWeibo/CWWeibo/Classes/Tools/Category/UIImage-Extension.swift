//
//  UIImage-Extension.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/10.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

extension UIImage {
    //计算图片在全屏显示模式下的frame
    func caclulateFrameInFullScreenMode() -> CGRect {
        let width = UIScreen.main.bounds.width
        let height = width / self.size.width * self.size.height
        
        var y :CGFloat = 0
        if height > UIScreen.main.bounds.height {
            y = 0
        } else {
            y = (UIScreen.main.bounds.height - height) * 0.5
        }
        
        return CGRect(x: 0, y: y, width: width, height: height)
    }
}
