//
//  WBStatusViewModel.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/7.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBStatusViewModel: NSObject {
    
    var status : WBStatusItem?
    
    // MARK:- 处理后的属性
    var sourceText : String?
    var creatTimeText : String?
    var verifiedImage : UIImage?
    var vipLevelImage : UIImage?
    
    init(status : WBStatusItem) {
        super.init()
        self.status = status
        
        //处理微博来源字符串
        if let source = status.source, status.source != ""  {
            let startLocation = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startLocation
            sourceText = (source as NSString).substring(with: NSRange(location: startLocation, length: length))
        }
        //处理时间字符串
        if let created_at = status.created_at {
            creatTimeText = Date.createDateString(createTime: created_at)
        }
        //处理认证类型
        let verified_type = status.user?.verified_type ?? -1
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
        //处理会员等级
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0 && mbrank <= 6 {
            vipLevelImage = UIImage(named: "common_icon_membership_level\(mbrank)")
        }

    }
}
