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
    var verified_type : Int = -1 {
        didSet {
            switch verified_type {
            case 0:
                verifiedImage = #imageLiteral(resourceName: "avatar_vip")
            case 2,3,5:
                verifiedImage = #imageLiteral(resourceName: "avatar_enterprise_vip")
            case 220:
                verifiedImage = #imageLiteral(resourceName: "avatar_grassroot")
            default:
                verifiedImage = nil
            }
        }
    }
    var mbrank : Int = 0 {
        didSet {
            if mbrank > 0 && mbrank <= 6 {
                vipLevelImage = UIImage(named: "common_icon_membership_level\(mbrank)")
            }
        }
    }
    
    // MARK:- 处理后的属性
    var verifiedImage : UIImage?
    var vipLevelImage : UIImage?
    
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
