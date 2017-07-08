//
//  WBPublishTextView.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/8.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import SnapKit

class WBPublishTextView: UITextView {
    
    fileprivate lazy var placeholderLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }

    

}


// MARK:- 初始化界面
extension WBPublishTextView {
    fileprivate func setup() {
        addSubview(placeholderLabel)
        
        placeholderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(10)
        }
        
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.font = font
        
        placeholderLabel.text = "分享新鲜事..."
        
        textContainerInset = UIEdgeInsets(top: 9, left: 7, bottom: 0, right: 9)
    }
}
