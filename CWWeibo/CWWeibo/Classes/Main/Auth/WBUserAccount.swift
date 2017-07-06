//
//  WBUserAccount.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/6.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBUserAccount: NSObject {
    
    var access_token : String?
    var expires_in : TimeInterval = 0 {
        didSet {
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    var uid : String?
    
    var expires_date : Date?
    
    var screen_name : String?
    
    var avatar_large : String?
    
    
    
    // MARK:- 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["access_token","expires_in","uid"]).description
    }
}
