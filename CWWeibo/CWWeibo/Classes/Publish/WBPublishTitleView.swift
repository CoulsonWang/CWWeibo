//
//  WBPublishTitleView.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/8.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import SnapKit

class WBPublishTitleView: UIView {
    
    fileprivate lazy var titleLabel = UILabel()
    fileprivate lazy var subtitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension WBPublishTitleView {
    fileprivate func setupLabels() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
        }
        subtitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        subtitleLabel.font = UIFont.systemFont(ofSize: 13)
        subtitleLabel.textColor = UIColor.lightGray
        
        titleLabel.text = "发布微博"
        subtitleLabel.text = WBUserAccountViewModel.sharedInstance.account?.screen_name
    }
}
