//
//  WBPhotoBrowserViewController.swift
//  CWWeibo
//
//  Created by Coulson_Wang on 2017/7/9.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

import UIKit
import SnapKit

private let PhotoBrowserCellID = "PhotoBrowserCellID"


class WBPhotoBrowserViewController: UIViewController {
    
    var indexPath : IndexPath?
    var picURLs : [URL]?
    
    lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: PhotoBrowserCollectionViewLayout())
    lazy var closeButton : UIButton = UIButton(backgroundColor: UIColor.lightGray, fontSize: 14, title: "关闭")
    lazy var saveButton : UIButton = UIButton(backgroundColor: UIColor.lightGray, fontSize: 14, title: "保存")

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUIs()
        
        collectionView.scrollToItem(at: indexPath!, at: .left, animated: false)
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
        
        collectionView.register(WBPhotoBrowserCollectionViewCell.self, forCellWithReuseIdentifier: PhotoBrowserCellID)
        collectionView.dataSource = self
        
        closeButton.addTarget(self, action: #selector(closeButtonClick), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonClick), for: .touchUpInside)
    }
}

extension WBPhotoBrowserViewController {
    @objc fileprivate func closeButtonClick() {
        dismiss(animated: true, completion: nil)
    }
    @objc fileprivate func saveButtonClick() {
        
    }
}

extension WBPhotoBrowserViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (picURLs?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoBrowserCellID, for: indexPath) as! WBPhotoBrowserCollectionViewCell
        
        cell.picURL = picURLs?[indexPath.item]
        
        return cell
    }
}

class PhotoBrowserCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        itemSize = collectionView!.bounds.size
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}
