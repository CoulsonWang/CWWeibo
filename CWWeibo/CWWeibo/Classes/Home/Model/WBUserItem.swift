//
//  WBUserItem.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/7.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//  用户模型

import UIKit



class WBUserItem: NSObject {
    
    // MARK:- 服务器返回属性
    var profile_image_url : String?
    var screen_name : String?
    var verified_type : Int = -1
    var mbrank : Int = 0
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
