//
//  AppDelegate.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/4.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor.orange
        UINavigationBar.appearance().tintColor = UIColor.orange
        
        return true
    }

}


func CWLog<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent.components(separatedBy: ".").first
        if let fileName = fileName {
            print("File:\(fileName),Function:\(funcName),Line:(\(lineNum)),Info:\(messsage)")
        }
        
    #endif
}
func CWLog(file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent.components(separatedBy: ".").first
        if let fileName = fileName {
            print("File:\(fileName),Function:\(funcName),Line:(\(lineNum))")
        }
        
    #endif
}
