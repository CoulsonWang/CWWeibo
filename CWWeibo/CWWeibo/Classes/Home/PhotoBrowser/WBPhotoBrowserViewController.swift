//
//  WBPhotoBrowserViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/9.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import SnapKit

class WBPhotoBrowserViewController: UIViewController {
    
    var indexPath : IndexPath?
    var picURLs : [URL]?
    
    lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    lazy var closeButton : UIButton = UIButton(backgroundColor: UIColor.lightGray, fontSize: 14, title: "关闭")
    lazy var saveButton : UIButton = UIButton(backgroundColor: UIColor.lightGray, fontSize: 14, title: "保存")

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUIs()
    }


}


extension WBPhotoBrowserViewController {
    func setupUIs() {
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        view.addSubview(saveButton)
        
        collectionView.frame = view.bounds
        closeButton.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.bottom.equalTo(-20)
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
        saveButton.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.bottom.equalTo(closeButton)
            make.size.equalTo(closeButton)
        }
    }
}
