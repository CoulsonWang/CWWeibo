//
//  WBVisitorView.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/5.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

    class func visitorView() -> WBVisitorView {
        return Bundle.main.loadNibNamed("WBVisitorView", owner: nil, options: nil)?.first as! WBVisitorView
    }
}
