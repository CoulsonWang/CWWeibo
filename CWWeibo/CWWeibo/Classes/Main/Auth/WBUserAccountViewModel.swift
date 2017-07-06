//
//  WBUserAccountTool.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/6.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBUserAccountViewModel {
    
    static let sharedInstance : WBUserAccountViewModel = WBUserAccountViewModel()
    
    var accountPath : String {
        let accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (accountPath as NSString).appendingPathComponent("account.plist")
    }
    
    var isLogin : Bool {
        if account == nil {
            return false
        }
        guard let expires_date = account?.expires_date else { return false }
        
        return expires_date.compare(Date()) == ComparisonResult.orderedDescending
    }
    
    var account : WBUserAccount? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? WBUserAccount
    }

    
}
