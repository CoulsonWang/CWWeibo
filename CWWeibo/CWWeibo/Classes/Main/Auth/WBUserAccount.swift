//
//  WBUserAccount.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/6.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBUserAccount: NSObject, NSCoding {
    
    var access_token : String?
    var expires_in : TimeInterval = 0 {
        didSet {
            //将剩余时限转化为具体时间保存起来
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
    
    // 重写description，打印成员属性
    override var description: String {
        return dictionaryWithValues(forKeys: ["access_token","expires_in","uid"]).description
    }
    
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }
}
