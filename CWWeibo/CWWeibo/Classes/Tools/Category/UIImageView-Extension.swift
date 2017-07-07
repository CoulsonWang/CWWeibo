//
//  UIImageView-Extension.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/7.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

extension UIImageView {
    func makeCircle() -> Void {
        layer.cornerRadius = bounds.size.width * 0.5
        layer.masksToBounds = true
    }
}
