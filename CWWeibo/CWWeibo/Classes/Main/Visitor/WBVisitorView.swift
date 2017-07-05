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
    
    // MARK:- 控件的属性
    @IBOutlet weak var registBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak private var rotationView: UIImageView!
    @IBOutlet weak private var iconView: UIImageView!
    @IBOutlet weak private var tipLabel: UILabel!

    
    // MARK:- 自定义函数
    func setupVisitorViewInfo(iconImage : UIImage, title : String) {
        iconView.image = iconImage
        tipLabel.text = title
        rotationView.isHidden = true
    }
    
    func addRotationAnim() {
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        rotationAnim.fromValue = 0
        rotationAnim.toValue = 2 * Double.pi
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 5
        rotationAnim.isRemovedOnCompletion = false
        
        rotationView.layer .add(rotationAnim, forKey: nil)
    }
}
