//
//  Date-Extension.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/6.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import Foundation

extension Date {
    static func createDateString(createTime : String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        formatter.locale = Locale(identifier: "localID")
        guard let createdDate = formatter.date(from: createTime) else { return "" }
        //计算创建时间与当前时间之间的时间差
        let interval = Int(Date().timeIntervalSince(createdDate))
        //根据时间差得出显示的文本
        //一分钟内
        if interval < 60 {
            return "刚刚"
        }
        //一小时内
        if interval < 60*60 {
            return "\(interval / 60)分钟前"
        }
        let calendar = Calendar.current
        //今天
        if calendar.isDateInToday(createdDate) {
            return "\(interval / (60*60))小时前"
        }
        //昨天
        if calendar.isDateInYesterday(createdDate) {
            formatter.dateFormat = "昨天 HH:mm"
            return formatter.string(from: createdDate)
        }
        //今年内
        if calendar.component(.year, from: createdDate) == calendar.component(.year, from: Date()) {
            formatter.dateFormat = "MM-dd HH:mm"
            return formatter.string(from: createdDate)
        }
        //不在今年
        if calendar.component(.year, from: createdDate) != calendar.component(.year, from: Date()) {
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            return formatter.string(from: createdDate)
        }
        return ""
    }
}
