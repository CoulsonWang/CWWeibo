//
//  WBStatusItem.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/6.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//  微博模型

import UIKit

class WBStatusItem: NSObject {
    
    // MARK:- 服务器返回属性
    var created_at : String?
    var source : String?
    var text : String?
    var mid : String?
    var user : WBUserItem?
    var pic_urls : [[String : String]]?
    var retweeted_status : WBStatusItem?
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
        
        if let userDict = dict["user"] as? [String : Any] {
            user = WBUserItem(dict: userDict)
        }
        if let retweetedStatusDict = dict["retweeted_status"] as? [String : Any] {
            retweeted_status = WBStatusItem(dict: retweetedStatusDict)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
