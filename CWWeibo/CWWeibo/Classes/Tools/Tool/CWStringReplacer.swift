//
//  CWStringReplacer.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/9.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class CWStringReplacer: NSObject {
    
    static let sharedInstance : CWStringReplacer = CWStringReplacer()
    
    private lazy var emoticonManager : EmoticonManager = EmoticonManager()
    
    func replaceEmoticons(context: String?, font: UIFont) -> NSAttributedString? {
        guard let context = context else { return nil }
        
        let pattern = "\\[.*?\\]"
        
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        
        let results = regex.matches(in: context, options: [], range: NSRange(location: 0, length: context.characters.count))
        
        let attrMStr = NSMutableAttributedString(string: context)
        
        //反向遍历
        for i in (0..<results.count).reversed() {
            let result = results[i]
            //取出chs
            let chs = (context as NSString).substring(with: result.range)
            guard let emoticonPath = searchEmoticonPath(chs: chs) else {
                continue
            }
            guard let emoticonImage = UIImage(contentsOfFile: emoticonPath) else{
                continue
            }
            let attachment = NSTextAttachment()
            attachment.image = emoticonImage
            attachment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let attrStr = NSAttributedString(attachment: attachment)
            //替换
            attrMStr.replaceCharacters(in: result.range, with: attrStr)
        }
        return attrMStr
    }
    
    private func searchEmoticonPath(chs: String) -> String? {
        for package in emoticonManager.packages {
            for emoticon in package.emoticons {
                if chs == emoticon.chs {
                    return emoticon.pngPath
                }
            }
        }
        return nil
    }
}
