//
//  WBStatusItem.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/6.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBStatusItem: NSObject {
    
    // MARK:- 服务器返回属性
    var created_at : String? {
        didSet {
            //处理时间字符串
            guard let created_at = created_at else { return }
            creatTimeText = Date.createDateString(createTime: created_at)
        }
    }
    var source : String? {
        didSet {
            //处理微博来源字符串
            guard let source = source, source != "" else { return }
            let startLocation = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startLocation
            sourceText = (source as NSString).substring(with: NSRange(location: startLocation, length: length))
        }
    }
    var text : String?
    var id : Int?
    
    // MARK:- 处理后的属性
    var sourceText : String?
    var creatTimeText : String?
    
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
