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
    var profileImageURL : URL?
    var pictureURLs : [URL] = [URL]()
    var mid_Int : Int?
    
    
    init(status : WBStatusItem) {
        super.init()
        self.status = status
        
        //处理微博来源字符串
        if let source = status.source, status.source != ""  {
            let startLocation = (source as NSString).range(of: ">").location + 1
            let length = (source as NSString).range(of: "</").location - startLocation
            let sourceStr = (source as NSString).substring(with: NSRange(location: startLocation, length: length))
            sourceText = "来自 " + sourceStr
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
        
        //处理头像URL
        if let profileURLString = status.user?.profile_image_url {
            profileImageURL = URL(string: profileURLString)
        } else {
            profileImageURL = nil
        }
        //处理配图URL数据
        let picURLDicts = (status.pic_urls?.count != 0) ? status.pic_urls : status.retweeted_status?.pic_urls
        if let picURLDicts = picURLDicts {
            for pictureDict in picURLDicts {
                guard let pictureURLString = pictureDict["thumbnail_pic"] else {
                    continue
                }
                pictureURLs.append(URL(string: pictureURLString)!)
            }
        }
        //处理mid字符串
        if let midValue = Int(status.mid!) {
            mid_Int = midValue
        }
        
        
    }
}
